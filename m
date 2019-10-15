Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB10D7738
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfJONP2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 09:15:28 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43588 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729551AbfJONP2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:15:28 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1iKMff-0003ki-Eq; Tue, 15 Oct 2019 15:15:27 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH v2 nf-next 0/2] netfilter: conntrack: free extension area immediately
Date:   Tue, 15 Oct 2019 15:19:13 +0200
Message-Id: <20191015131915.28385-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

conntrack extensions are free'd via kfree_rcu, but there appears to be
no need for this anymore.

Lookup doesn't access ct->ext.  All other accesses i found occur
after taking either the hash bucket lock, the dying list lock,
or a ct reference count.

Only exception was ctnetlink, where we could potentially see a
ct->ext that is about to be free'd via krealloc on other cpu.
Since that only affects unconfirmed conntracks, just skip dumping
extensions for those.

