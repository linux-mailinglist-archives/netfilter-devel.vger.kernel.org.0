Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ACB792981
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Sep 2023 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350018AbjIEQ0r (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354053AbjIEJ2z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:28:55 -0400
X-Greylist: delayed 3278 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 02:28:52 PDT
Received: from mail.equinoxrise.pl (mail.equinoxrise.pl [217.61.112.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E8612E
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Sep 2023 02:28:52 -0700 (PDT)
Received: by mail.equinoxrise.pl (Postfix, from userid 1002)
        id 02254850F8; Tue,  5 Sep 2023 09:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=equinoxrise.pl;
        s=mail; t=1693899736;
        bh=v6OgBfK5dN7P5dQ0wCu59rOfZaiqziJeLNblJ8dOcGI=;
        h=Date:From:To:Subject:From;
        b=0icHdcEvuzgqvsg0PAwuQ/sBWQs6KMT1QOVsSQrfUxXg3MneQhlS6TfmAl47+nABg
         SIvzmFDLfEav706K6bJPGUvOLd19iiVWfNjJjEqBnQekHN5aIj4+5hygxf0B3L9sif
         vzNxdk3iMIahQiOQODm0IjqXA2NxWyDq+nRORtfQFWqU5gE/1HHm1DsgBqpkN7GQAx
         fst0Ozw+xLNpiw1iz2QwksQwcWwCsXg73GBWSKGNZxD0l7YfC8Y/aomxBGx6DYbm2m
         TxBywcop/3HhbAnqJCDX86kvaq3cjxitZoV+n8mx52dkFS/XEIEeY0QYXPTMsBs6Xw
         Fu8fYDdlNP7sA==
Received: by mail.equinoxrise.pl for <netfilter-devel@vger.kernel.org>; Tue,  5 Sep 2023 07:40:39 GMT
Message-ID: <20230905084500-0.1.8.1c3o.0.ijoena3eo2@equinoxrise.pl>
Date:   Tue,  5 Sep 2023 07:40:39 GMT
From:   "Mateusz Talaga" <mateusz.talaga@equinoxrise.pl>
To:     <netfilter-devel@vger.kernel.org>
Subject: Prezentacja
X-Mailer: mail.equinoxrise.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_CSS_A,URIBL_DBL_SPAM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dzie=C5=84 dobry!

Czy m=C3=B3g=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re umo=C5=
=BCliwia monitoring ka=C5=BCdego auta w czasie rzeczywistym w tym jego po=
zycj=C4=99, zu=C5=BCycie paliwa i przebieg?

Dodatkowo nasze narz=C4=99dzie minimalizuje koszty utrzymania samochod=C3=
=B3w, skraca czas przejazd=C3=B3w, a tak=C5=BCe tworzenie planu tras czy =
dostaw.

Z naszej wiedzy i do=C5=9Bwiadczenia korzysta ju=C5=BC ponad 49 tys. Klie=
nt=C3=B3w. Monitorujemy 809 000 pojazd=C3=B3w na ca=C5=82ym =C5=9Bwiecie,=
 co jest nasz=C4=85 najlepsz=C4=85 wizyt=C3=B3wk=C4=85.

Bardzo prosz=C4=99 o e-maila zwrotnego, je=C5=9Bli mogliby=C5=9Bmy wsp=C3=
=B3lnie om=C3=B3wi=C4=87 potencja=C5=82 wykorzystania takiego rozwi=C4=85=
zania w Pa=C5=84stwa firmie.


Pozdrawiam
Mateusz Talaga
