Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD2324202
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Feb 2021 17:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBXQYQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Feb 2021 11:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhBXQYO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:24:14 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C5C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Feb 2021 08:23:32 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lEwwl-00031M-G9; Wed, 24 Feb 2021 17:23:31 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 0/3] netfilter: nat: fix ancient dnat+edemux bug
Date:   Wed, 24 Feb 2021 17:23:18 +0100
Message-Id: <20210224162321.4899-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Netfilter NAT collision handling + TCP edemux can cause packets to end
up with the wrong socket.
This happens since TCP early demux was added more than 8 years ago, so
this needs very rare and specific conditions to trigger.

Patch 1 fixes the bug.
Patch 2 rewords a debug message that imlies packets are treated
as invalid while they are not.
Patch 3 adds a test case for this.  On unpatched kernel this script
should error out with:
(UNKNOWN) [10.96.0.1] 443 (https) : Connection timed out
FAIL: nc cannot connect via NAT'd address

Florian Westphal (3):
  netfilter: nf_nat: undo erroneous tcp edemux lookup
  netfilter: conntrack: avoid misleading 'invalid' in log message
  selftests: netfilter: test nat port clash resolution interaction with
    tcp early demux

 net/netfilter/nf_conntrack_proto_tcp.c        |  6 +-
 net/netfilter/nf_nat_proto.c                  | 25 ++++-
 tools/testing/selftests/netfilter/Makefile    |  2 +-
 .../selftests/netfilter/nf_nat_edemux.sh      | 99 +++++++++++++++++++
 4 files changed, 125 insertions(+), 7 deletions(-)
 create mode 100755 tools/testing/selftests/netfilter/nf_nat_edemux.sh

-- 
2.26.2

