Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160848C1ED
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Aug 2019 22:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfHMUMV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Aug 2019 16:12:21 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:57618 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfHMUMV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:12:21 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hxd9X-0004B8-U2; Tue, 13 Aug 2019 22:12:19 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH v2 nftables 0/3] un-break nftables on big-endian arches
Date:   Tue, 13 Aug 2019 22:12:43 +0200
Message-Id: <20190813201246.5543-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nftables 0.9.1 fails on s390x.  Breakage includes:

- "jump foo" is rejected
- chain policies are treated as drop
- chain priority is always set to 0 (same bug though).

Also, last test case reveals problems with receive buffer sizes,
these have been fixed as well.

After these changes, all test cases work, except one.
The failure in that test case is caused by timeout rounding
errors due to CONFIG_HZ=100, I'll leave that for the time being
given HZ=100 is rare noways and the "fix" is to adjust the test case.

Florian Westphal (3):
      src: fix jumps on bigendian arches
      src: parser: fix parsing of chain priority and policy on bigendian
      src: mnl: retry when we hit -ENOBUFS

 datatype.c     |   27 ++++++++++++++++++---------
 mnl.c          |   12 ++++++++++--
 netlink.c      |   16 +++++++++++++---
 parser_bison.y |    6 ++++--
 4 files changed, 45 insertions(+), 16 deletions(-)

