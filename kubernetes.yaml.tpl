apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: otc
    cluster: otc
    otc: "true"
  name: otc
  namespace: default
spec:
  selector:
    matchLabels:
      otc: "true"
  strategy:
    rollingUpdate:
      maxSurge: 10%
      maxUnavailable: 10%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: otc
        cluster: otc
        otc: "true"
    spec:
      containers:
      - env:
        - name: QPATHWAYS_DB_HOST
          valueFrom:
            configMapKeyRef:
              key: QPATHWAYS_DB_HOST
              name: qpathways-staging-config
        - name: QPATHWAYS_DB_NAME
          valueFrom:
            configMapKeyRef:
              key: QPATHWAYS_DB_NAME
              name: qpathways-staging-config
        - name: QPATHWAYS_DB_PORT
          valueFrom:
            configMapKeyRef:
              key: QPATHWAYS_DB_PORT
              name: qpathways-staging-config
        - name: QPATHWAYS_NOTIFICATION_DB_NAME
          valueFrom:
            configMapKeyRef:
              key: QPATHWAYS_NOTIFICATION_DB_NAME
              name: qpathways-staging-config
        - name: QPATHWAYS_AUTH_DB_NAME
          valueFrom:
            configMapKeyRef:
              key: QPATHWAYS_AUTH_DB_NAME
              name: qpathways-staging-config
        - name: DB_USER
          valueFrom:
            secretKeyRef:
              key: DB_USER
              name: qpathways-staging-secret
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              key: DB_PASSWORD
              name: qpathways-staging-secret
        image: gcr.io/GOOGLE_CLOUD_PROJECT/github.com/triarqhealthotc/otc-services:COMMIT_SHA
        imagePullPolicy: IfNotPresent
        name: otcservices
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      imagePullSecrets:
      - name: gcr
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status: {}

