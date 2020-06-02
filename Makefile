# $FreeBSD$

PORTNAME=	ohc
PORTVERSION=	0.7.0
CATEGORIES=	java devel
MASTER_SITES=	LOCAL:maven
DISTFILES+=	${PORTNAME}-${PORTVERSION}-maven-repository.tar.gz:maven

MAINTAINER=	language.devel@gmail.com
COMMENT=	Off-heap-cache for Java

LICENSE=	APACHE20

P_B_DEPENDS=	snappyjava>0:archivers/snappy-java \
		${LOCALBASE}/share/java/maven33/bin/mvn:devel/maven33
PATCH_DEPENDS=	${P_B_DEPENDS}
BUILD_DEPENDS=	${P_B_DEPENDS}
RUN_DEPENDS=	snappyjava>0:archivers/snappy-java

OPTIONS_DEFINE=	TESTS
TESTS_DESC=	Compile and run tests and benchmarking

USE_GITHUB=	yes
GH_ACCOUNT=	snazy

JAVA_VERSION=	8 11
JAVA_VENDOR=	openjdk
USE_JAVA=	yes

PLIST_FILES=	${JAVAJARDIR}/ohc-core.jar

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MTESTS}
NOTESTS_FLAG=	
.else
NOTESTS_FLAG=	-Dmaven.test.skip=true
.endif

SNAPPY_VERSION=`${PKG_QUERY} '%v' snappyjava`

post-patch:
	SNAPPY_VERSION=$$( ${PKG_QUERY} '%v' snappyjava ) ; cd ${WRKSRC} ; \
		${REINPLACE_CMD} "s|version.org.xerial.snappy>[0-9].[0-9].[0-9].[0-9]<|version.org.xerial.snappy>$$SNAPPY_VERSION<|" pom.xml ; \
		${LOCALBASE}/share/java/maven33/bin/mvn install:install-file -Dfile=${JAVAJARDIR}/snappy-java.jar \
			-DgroupId=org.xerial.snappy -DartifactId=snappy-java -Dversion=$$SNAPPY_VERSION -Dpackaging=jar -Dmaven.repo.local=${WRKDIR}/repository --offline

post-patch-TESTS-off:
	${REINPLACE_CMD} -e 's|<module>ohc-benchmark</module>|<!--module>ohc-benchmark</module-->|' \
			-e 's|<module>ohc-jmh</module>|<!--module>ohc-jmh</module-->|' ${WRKSRC}/pom.xml

do-build:
	cd ${WRKSRC} ; ${LOCALBASE}/share/java/maven33/bin/mvn clean install -Dmaven.repo.local=${WRKDIR}/repository ${NOTESTS_FLAG} --offline

do-install:
	${INSTALL_DATA} ${WRKSRC}/ohc-core/target/ohc-core-${PORTVERSION}.jar ${STAGEDIR}${JAVAJARDIR}/ohc-core.jar

.include <bsd.port.mk>
