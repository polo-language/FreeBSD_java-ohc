# $FreeBSD$

PORTNAME=	ohc
PORTVERSION=	0.4.4
CATEGORIES=	java devel
#MASTER_SITES=

MAINTAINER=	language.devel@gmail.com
COMMENT=	Off-heap-cache for Java

LICENSE=	APACHE20

BUILD_DEPENDS=	snappyjava>0:archivers/snappy-java \
		${LOCALBASE}/share/java/maven33/bin/mvn:devel/maven33
RUN_DEPENDS=	snappyjava>0:archivers/snappy-java

USE_GITHUB=	yes
GH_ACCOUNT=	snazy

JAVA_VERSION=	1.8
JAVA_VENDOR=	openjdk
USE_JAVA=	yes
REINPLACE_ARGS=	-i ''
#SUB_LIST=	JAVAJARDIR=${JAVAJARDIR} # export snappy version for mvn build.xml?

post-patch:
	SNAPPY_VERSION=$$( ${PKG_QUERY} '%v' snappyjava ) ; \
		cd ${WRKSRC} ; \
		${REINPLACE_CMD} "s|version.org.xerial.snappy>1.1.1.7<|version.org.xerial.snappy>$$SNAPPY_VERSION<|" pom.xml ; \
		${LOCALBASE}/share/java/maven33/bin/mvn install:install-file -Dfile=${JAVAJARDIR}/snappy-java.jar -DgroupId=org.xerial.snappy -DartifactId=snappy-java -Dversion=$$SNAPPY_VERSION -Dpackaging=jar -Dmaven.repo.local=${WRKDIR}/repository --offline

do-build:
	cd ${WRKSRC} ; ${LOCALBASE}/share/java/maven33/bin/mvn clean install -Dmaven.repo.local=${WRKDIR}/repository --offline

do-install:
	${INSTALL_PROGRAM} ${STAGEDIR}${DATADIR}/ohc-core/target/ohc-core-${PORTVERSION}.jar ${JAVAJARDIR}/
	${INSTALL_PROGRAM} ${STAGEDIR}${DATADIR}/ohc-core-j8/target/ohc-core-j8-${PORTVERSION}.jar ${JAVAJARDIR}/

.include <bsd.port.mk>
