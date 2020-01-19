Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6C141FDF
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2020 20:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgAST60 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Jan 2020 14:58:26 -0500
Received: from kadath.azazel.net ([81.187.231.250]:49944 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgAST60 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Jan 2020 14:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dou/t7vYLoV6+omV+8WDLQgxlT68ujjCvJ0bK7eVjZ8=; b=YcCFQUhLvzhPFL6hZrq2DCzXMI
        k/frDT37WTWJOCpjYVu9J5O2tMsFynlQpCFrBS8iNpYPSbkIzWZkD2KQN4f0Fkh0pl7Vb3ritbXOY
        T1jfztzIQGFGvmYW5bAW15epKRcf7kqV2d/2+1xizCdiS5PFuXZ/axkgmyL74AKlAapOE5caJrkLg
        AevtWvkI3htBoWHQu+KIL0cCM2iPC3R2JFMROf+zzxuTkusDUDGpexpQONrhVIr4+1cY51TYoXNta
        x9FUDNdFc41pHU2AABUZB+noT/ZFnlaNfqY3MwvMEDFniZtPadrO0CzvvlrLqkAd3E1fI5youetUJ
        Pl/eovQQ==;
Received: from celephais.dreamlands ([192.168.96.3] helo=azazel.net)
        by kadath.azazel.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1itGiG-00009y-Uv
        for netfilter-devel@vger.kernel.org; Sun, 19 Jan 2020 19:58:24 +0000
Date:   Sun, 19 Jan 2020 19:58:22 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v2 0/9] bitwise shift support
Message-ID: <20200119195822.GB1416073@azazel.net>
References: <20200118212319.253112-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20200118212319.253112-1-jeremy@azazel.net>
X-SA-Exim-Connect-IP: 192.168.96.3
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2020-01-18, at 21:23:10 +0000, Jeremy Sowden wrote:
> The kernel supports bitwise shift operations.  This patch-set adds the
> support to nft.  There are a few preliminary housekeeping patches.

There are a couple of bugs in this set.  I'll fix them and send out v3
shortly.

J.

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEd/6/sDFjb+OCRmRMonv1GCHZ79cFAl4ktNQACgkQonv1GCHZ
79ezwAv/X5WYPFz69fBWjEEL2DSeFMszV0VLHz9SSY0I+H9LL5nW2/c6oSLg1f2r
S6hVL4ZcfPi0djmrjC679zOScETllma0ZmjryfxM0MMmoxRSSrg90QrylbVwGO2l
oR12zjmskm2R2diP1iM86dpg+MCNer+I+HHUTxDTr1XfEQlQjlz3VtatP/A4MJWy
ruiETJABBpvaVW5NiCpxqlJZITsFDbGB7L5vE7Qz/ykTzOtGnz4I1UDREM1tiqMw
CuNa1YxN8HbpoDas4I8I9BaWml2e+D3l/ymF6vJJdl+X7QzE3gemvOXHl1S9LvPf
f/Tj2vE/2jTUcx6T+2KZb5n4KFoP4mc+OMHbX7A7ZCAZiOCLCE0tiMkNp4vC4lvw
5Wvz5e0qJe+52qQ+JOrAlg2u189Om9rKgd2e82rUeMlrS1GKJsRCyO518hUTHX68
nJlgRp0xCqnvhjTYaYsaRf3xuyNSIhXkj9x+SBFPnub/2YirXUI49JLsHT/ZLe6v
GYxEum5b
=4pdx
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
