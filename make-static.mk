static-upload:
	aws s3 sync services/static s3://code-basics.ru
