Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842CDEC6E1
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 Nov 2019 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfKAQga (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 1 Nov 2019 12:36:30 -0400
Received: from smtp-out.kfki.hu ([148.6.0.48]:35089 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfKAQga (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:36:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 26CCECC0130;
        Fri,  1 Nov 2019 17:36:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
        :from:from:received:received:received; s=20151130; t=1572626187;
         x=1574440588; bh=gvrkrixSYM736SG/mzn94zj+1MTjQh6GQHYtTBlQA9o=; b=
        OFZ5gJakJACYqp2cuN+cnYcz6KpOWzznjeDw48FZk6sgg+R7vPN3euTfs2PI1FIu
        cS8lYH+Vp1/rn9vKqVsb5p0OuUnZe9rH7zU1TycFImtZdmxxM4KgE1XoLM5i648A
        JxToBrjsSG3iRaeYZmyCKR3yh9QWWqB1t731l69K/qI=
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Fri,  1 Nov 2019 17:36:27 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 155D2CC0123;
        Fri,  1 Nov 2019 17:36:27 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 08D6F21A47; Fri,  1 Nov 2019 17:36:26 +0100 (CET)
From:   Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 0/1] ipset patches for nf-next
Date:   Fri,  1 Nov 2019 17:36:25 +0100
Message-Id: <20191101163626.10649-1-kadlec@blackhole.kfki.hu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

Please consider applying the next patch for the nf-next tree:

- Add wildcard support to hash:net,iface which makes possible to
  match interface prefixes besides complete interfaces names, from
  Kristian Evensen.

Best regards,
Jozsef

The following changes since commit d5a721c96a4411d3f35545b694fc9794fbbfc9=
8e:

  atm: remove unneeded semicolon (2019-10-28 16:47:22 -0700)

are available in the Git repository at:

  git://blackhole.kfki.hu/nf-next 2eb06a8c6254dc68

for you to fetch changes up to 2eb06a8c6254dc68b4f8519918e59197758decaf:

  netfilter: ipset: Add wildcard support to net,iface (2019-11-01 17:19:1=
9 +0100)

----------------------------------------------------------------
Kristian Evensen (1):
      netfilter: ipset: Add wildcard support to net,iface

 include/uapi/linux/netfilter/ipset/ip_set.h |  2 ++
 net/netfilter/ipset/ip_set_hash_netiface.c  | 23 ++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)
