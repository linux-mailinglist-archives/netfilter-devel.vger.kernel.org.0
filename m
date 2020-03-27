Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08363194EDB
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Mar 2020 03:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgC0CY5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Mar 2020 22:24:57 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:41640 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbgC0CY5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:24:57 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1jHeg4-000687-8z; Fri, 27 Mar 2020 03:24:56 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 0/4] netfilter: nf_queue: rework refcount handling
Date:   Fri, 27 Mar 2020 03:24:45 +0100
Message-Id: <20200327022449.7411-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

running nft_queue.sh selftest with refcount debugging
enabled triggers following splat:

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 2441 at lib/refcount.c:25 refcount_warn_saturate+0xbc/0x110
RIP: 0010:refcount_warn_saturate+0xbc/0x110
[..]
Call Trace:
 nf_queue_entry_get_refs+0x194/0x1b0
 nf_queue+0x38b/0x640
 nf_reinject+0x264/0x280
 nfqnl_recv_verdict+0x5d5/0x920
 nfnetlink_rcv_msg+0x27a/0x460

This is because nf_queue uses following pattern:
nf_queue_entry_get_refs()
  nf_queue() // leave rcu protection
  // nfnetlink, wait for verdict
  // sk might be closed now
nf_reinject // reenter rcu protection
  nf_queue_entry_release_refs // refcount can drop to 0
  // iterate/call remaining hooks and okfn

If the hook iteration results in another nf_queue() call, above splat
might be triggered.

This series fixes this by deferring the call to
nf_queue_entry_release_refs() until after the hook iteration/okfn
returns; i.e. another nf_queue invocation from nf_reinject path will
not observe a zero refcount.

This series also applies to nf, but given we're a bit further along in
release cycle nf-next might be better; this fix isn't simple,
unfortunately.

