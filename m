Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1222DDD1
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 May 2019 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfE2NOQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 29 May 2019 09:14:16 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40290 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfE2NOQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 29 May 2019 09:14:16 -0400
Received: from localhost ([::1]:53378 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hVyPG-0006xf-Gn; Wed, 29 May 2019 15:14:14 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>
Subject: [nft PATCH 0/4] Fix ENOBUFS error in large transactions with --echo
Date:   Wed, 29 May 2019 15:13:42 +0200
Message-Id: <20190529131346.23659-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When committing a larger transaction (e.g. adding 300 rules) with echo
output turned on, mnl_batch_talk() would report ENOBUFS after the first
call to mnl_socket_recvfrom(). (ENOBUFS indicates congestion in netlink
socket.)

The problem in mnl_batch_talk() was a combination of unmodified socket
recv buffer, use of select() and unhandled ENOBUFS condition (abort
instead of retry).

This series solves the issue, admittedly a bit in sledge hammer method:
Maximize nf_sock receive buffer size for all users, make
mnl_batch_talk() fetch more messages at once and retry upon ENOBUFS
instead of just giving up.

There was also a problem with select() use which motivated the loop
rewrite in Patch 3. Actually, replacing the whole loop by a simple call
to nft_mnl_recv() worked and was even sufficient in avoiding ENOBUFS
condition, but I am not sure if that has other side-effects.

Phil Sutter (4):
  mnl: Maximize socket receive buffer by default
  mnl: Increase receive buffer in mnl_batch_talk()
  mnl: Fix and simplify mnl_batch_talk()
  tests/shell: Test large transaction with echo output

 src/mnl.c                                     | 82 ++++++++++---------
 tests/shell/testcases/transactions/0049huge_0 | 14 ++++
 2 files changed, 58 insertions(+), 38 deletions(-)
 create mode 100755 tests/shell/testcases/transactions/0049huge_0

-- 
2.21.0

