Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56E14E6AA
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Jun 2019 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfFULDf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Jun 2019 07:03:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52060 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFULDe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:03:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3D7758057C; Fri, 21 Jun 2019 13:03:22 +0200 (CEST)
Date:   Fri, 21 Jun 2019 13:03:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        kernel list <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au
Subject: Next 20190620: fails to compile in netfilter on x86-32
Message-ID: <20190621110311.GF24145@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I get this during compilation:

  CC      net/netfilter/core.o
  In file included from net/netfilter/core.c:19:0:
  ./include/linux/netfilter_ipv6.h: In function
  =E2=80=98nf_ipv6_cookie_init_sequence=E2=80=99:
  ./include/linux/netfilter_ipv6.h:174:2: error: implicit declaration
  of function =E2=80=98__cookie_v6_init_sequence=E2=80=99
  [-Werror=3Dimplicit-function-declaration]
    return __cookie_v6_init_sequence(iph, th, mssp);
      ^
      ./include/linux/netfilter_ipv6.h: In function
  =E2=80=98nf_cookie_v6_check=E2=80=99:
  ./include/linux/netfilter_ipv6.h:189:2: error: implicit declaration
  of function =E2=80=98__cookie_v6_check=E2=80=99
  [-Werror=3Dimplicit-function-declaration]
    return __cookie_v6_check(iph, th, cookie);
      ^
      cc1: some warnings being treated as errors
      scripts/Makefile.build:278: recipe for target
  'net/netfilter/core.o' failed
  make[2]: *** [net/netfilter/core.o] Error 1
  scripts/Makefile.build:498: recipe for target 'net/netfilter' failed
  make[1]: *** [net/netfilter] Error 2

Is it known?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0MuW8ACgkQMOfwapXb+vIuCACgnvmyRRIBs4fi3Dhtj5v27hz9
ITUAnAgSedTWKtmneZ6Znt5jKedfxIm5
=g/aU
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
