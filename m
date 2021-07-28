Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5B3D90C7
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jul 2021 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhG1Oi2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Jul 2021 10:38:28 -0400
Received: from smtp-out.kfki.hu ([148.6.0.48]:41791 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235420AbhG1Oi2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:38:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id DADDACC00FC;
        Wed, 28 Jul 2021 16:38:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Wed, 28 Jul 2021 16:38:22 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 9CAA5CC00F3;
        Wed, 28 Jul 2021 16:38:22 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 907763412EC; Wed, 28 Jul 2021 16:38:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id 8ABA43412EB;
        Wed, 28 Jul 2021 16:38:22 +0200 (CEST)
Date:   Wed, 28 Jul 2021 16:38:22 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: [ANNOUNCE] ipset 7.14 released
Message-ID: <8c12d23-4fcb-cfb9-4759-5496c597492f@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

Ipset 7.14 released to fix the dynamic library issue and also a kernel 
compiling problem on 32bit systems:

Userspace changes:
  - Add missing function to libipset.map and bump library version
    (reported by Jan Engelhardt)

Kernel part changes:
  - 64bit division isn't allowed on 32bit, replace it with shift

You can download the source code of ipset from:
        https://ipset.netfilter.org
        ftp://ftp.netfilter.org/pub/ipset/
        git://git.netfilter.org/ipset.git

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.mta.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics, Hungarian Academy of Sciences
          H-1525 Budapest 114, POB. 49, Hungary
