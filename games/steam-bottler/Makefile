PORTNAME=       steam-bottler
DISTVERSION=    1.0.6
CATEGORIES=     games
MASTER_SITES=   https://github.com/es-j3/${PORTNAME}/archive/${PORTVERSION}${EXTRACT_SUFX}?dummy=/

MAINTAINER=     alexander.nogal@proton.me
COMMENT=        Steam Windows gaming in a wine bottle on FreeBSD
WWW=            https://github.com/es-j3/steam-bottler

LICENSE=        BSD2CLAUSE
LICENSE_FILE=   ${WRKSRC}/LICENSE

ONLY_FOR_ARCHS= amd64 i386
ONLY_FOR_ARCHS_REASON=  Wine is only supported on x86 platforms

RUN_DEPENDS=    wine:emulators/wine \
		${LOCALBASE}/wine-proton:emulators/wine-proton \
		winetricks:emulators/winetricks \
		zenity:x11/zenity

NO_BUILD=       yes

WRKSRC=         ${WRKDIR}/${PORTNAME}-${PORTVERSION}

PLIST_FILES=    bin/steam-bottler

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/src/steam-bottler ${STAGEDIR}${PREFIX}/bin/steam-bottler

.include <bsd.port.mk>
