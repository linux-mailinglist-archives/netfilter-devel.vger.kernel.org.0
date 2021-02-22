Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650BC3221B6
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Feb 2021 22:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBVVpO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Feb 2021 16:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBVVpH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:45:07 -0500
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [IPv6:2001:738:5001::48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A054C061574
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Feb 2021 13:44:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 9F8F0CC0187;
        Mon, 22 Feb 2021 22:44:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon, 22 Feb 2021 22:44:22 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 6912BCC0186;
        Mon, 22 Feb 2021 22:44:21 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 4A09F340D5D; Mon, 22 Feb 2021 22:44:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id 4594A340D5C;
        Mon, 22 Feb 2021 22:44:21 +0100 (CET)
Date:   Mon, 22 Feb 2021 22:44:21 +0100 (CET)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: increasing ip_list_tot in net/netfilter/xt_recent.c for a
 non-modular kernel
In-Reply-To: <df5eb9af-568a-ef0e-bc4f-33b0fbe1307f@gmx.de>
Message-ID: <2981762-4fc1-38be-d658-31413e36e4cd@netfilter.org>
References: <df5eb9af-568a-ef0e-bc4f-33b0fbe1307f@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="110363376-1535550823-1614030261=:362"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--110363376-1535550823-1614030261=:362
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Feb 2021, Toralf F=C3=B6rster wrote:

> I'm curious if there's a better solution than local patching like:

See "modinfo xt_recent": you can tune it via a module parameter.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
--110363376-1535550823-1614030261=:362--
