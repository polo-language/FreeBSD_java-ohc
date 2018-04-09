# $FreeBSD$

PORTNAME=	ohc
PORTVERSION=	0.4.4
CATEGORIES=	java devel
MASTER_SITES=	LOCAL:maven
DISTFILES+=	${PORTNAME}-${PORTVERSION}-maven-repository.tar.gz:maven

MAINTAINER=	language.devel@gmail.com
COMMENT=	Off-heap-cache for Java

LICENSE=	APACHE20

BUILD_DEPENDS=	snappyjava>0:archivers/snappy-java \
		${LOCALBASE}/share/java/maven33/bin/mvn:devel/maven33
RUN_DEPENDS=	snappyjava>0:archivers/snappy-java

OPTIONS_DEFINE=	TESTS
TESTS_DESC=	Compile and run tests and benchmarking

USE_GITHUB=	yes
GH_ACCOUNT=	snazy

JAVA_VERSION=	1.8
JAVA_VENDOR=	openjdk
USE_JAVA=	yes
REINPLACE_ARGS=	-i ''

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MTESTS}
NOTESTS_FLAG=	
.else
NOTESTS_FLAG=	-Dmaven.test.skip=true
.endif

post-patch:
	SNAPPY_VERSION=$$( ${PKG_QUERY} '%v' snappyjava ) ; \
		cd ${WRKSRC} ; \
		${REINPLACE_CMD} "s|version.org.xerial.snappy>1.1.1.7<|version.org.xerial.snappy>$$SNAPPY_VERSION<|" pom.xml ; \
		${LOCALBASE}/share/java/maven33/bin/mvn install:install-file -Dfile=${JAVAJARDIR}/snappy-java.jar -DgroupId=org.xerial.snappy -DartifactId=snappy-java -Dversion=$$SNAPPY_VERSION -Dpackaging=jar -Dmaven.repo.local=${WRKDIR}/repository --offline

post-patch-TESTS-off:
	${REINPLACE_CMD} "s|<module>ohc-benchmark</module>|<!--module>ohc-benchmark</module-->|" ${WRKSRC}/pom.xml
	${REINPLACE_CMD} "s|<module>ohc-jmh</module>|<!--module>ohc-jmh</module-->|" ${WRKSRC}/pom.xml

do-build:
	cd ${WRKSRC} ; ${LOCALBASE}/share/java/maven33/bin/mvn clean install -Dmaven.repo.local=${WRKDIR}/repository --offline ${NOTESTS_FLAG}

do-install:
	${INSTALL_DATA} ${WRKSRC}/ohc-core/target/ohc-core-${PORTVERSION}.jar ${STAGEDIR}${JAVAJARDIR}/ohc-core.jar
	${INSTALL_DATA} ${WRKSRC}/ohc-core-j8/target/ohc-core-j8-${PORTVERSION}.jar ${STAGEDIR}${JAVAJARDIR}/ohc-core-j8.jar

.include <bsd.port.mk>
