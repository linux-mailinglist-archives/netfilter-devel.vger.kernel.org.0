Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453596D189F
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 Mar 2023 09:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCaHcD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 Mar 2023 03:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCaHcC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:32:02 -0400
Received: from mail.crawnon.pl (mail.crawnon.pl [51.68.198.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4845FB44E
        for <netfilter-devel@vger.kernel.org>; Fri, 31 Mar 2023 00:32:01 -0700 (PDT)
Received: by mail.crawnon.pl (Postfix, from userid 1002)
        id 6C432A5864; Fri, 31 Mar 2023 07:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crawnon.pl; s=mail;
        t=1680247916; bh=vdn5P4TcqbO5KLDdR/tfEP9AjvOe1HPkPv4ZFGYr8oc=;
        h=Date:From:To:Subject:From;
        b=Dub4j4uj9iWZXl1Zyc96UX4kwRnJx2vfNBV0hIw/omAHzUR0illFjuJOo4uA399wy
         DwPHC+15jFrvzti/sNp7s8OIQBdNjlyHjY+ZYVcSLw3xjLnnrJkwsETCxduyWUcP/R
         U0cDzXhs9dZRy5jpyRTHk4vkAaAjsQLHw2BNvv7ecwlMGPlSPwGV0U6gBZEi7OkAUV
         fPIsnizcPntQecNQGlFo0ov4EvPJrWW38QfSJAUK5hbp3nBNmAaQYhV+Ml0hCcciYH
         +7vd/Y7N3RFjzmF2xG2q3FlV4XDKlqy1SddeB3cJcaEJnq2yVaoS/aeCLcL/RHoIwW
         UWb+/RhbUGveg==
Received: by mail.crawnon.pl for <netfilter-devel@vger.kernel.org>; Fri, 31 Mar 2023 07:31:20 GMT
Message-ID: <20230331064500-0.1.a3.vd5d.0.75tq8lmni2@crawnon.pl>
Date:   Fri, 31 Mar 2023 07:31:20 GMT
From:   =?UTF-8?Q? "Miko=C5=82aj_Fiodorczyk" ?= 
        <mikolaj.fiodorczyk@crawnon.pl>
To:     <netfilter-devel@vger.kernel.org>
Subject: Fotowoltaika- propozycja instalacji
X-Mailer: mail.crawnon.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: crawnon.pl]
        *  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [51.68.198.42 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: crawnon.pl]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dzie=C5=84 dobry,
=20
Czy rozwa=C5=BCali Pa=C5=84stwo monta=C5=BC systemu fotowoltaicznego?
=20
Instalacja fotowoltaiczna jest najlepszym sposobem na obni=C5=BCenie wyso=
ko=C5=9Bci rachunk=C3=B3w za pr=C4=85d (pozostaj=C4=85 tylko op=C5=82aty =
sta=C5=82e) i zabezpieczenie si=C4=99 przed rosn=C4=85cymi cenami energii=
 elektrycznej. Jest to w pe=C5=82ni odnawialne i bezemisyjne =C5=BAr=C3=B3=
d=C5=82o energii, dzi=C4=99ki czemu przyczyniamy si=C4=99 do ochrony =C5=9B=
rodowiska naturalnego.
=20
Dzia=C5=82amy od wielu lat na rynku energetycznym. Przygotujemy projekt, =
wycen=C4=99 oraz kompleksowo wykonamy i zg=C5=82osimy realizacj=C4=99 do =
zak=C5=82adu energetycznego.=20
=20
Czy chc=C4=85 Pa=C5=84stwo pozna=C4=87 nasz=C4=85 propozycj=C4=99? =20


Pozdrawiam,
Miko=C5=82aj Fiodorczyk
