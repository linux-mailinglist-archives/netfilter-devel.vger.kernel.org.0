Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA37142F87
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jan 2020 17:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgATQZo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jan 2020 11:25:44 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:60790 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgATQZo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:25:44 -0500
Received: from localhost ([::1]:45648 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1itZry-00062C-IC; Mon, 20 Jan 2020 17:25:42 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/4] Fixes for a recent covscan run
Date:   Mon, 20 Jan 2020 17:25:36 +0100
Message-Id: <20200120162540.9699-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Minor issues only, mostly in hard to reach code paths.

Phil Sutter (4):
  netlink: Fix leak in unterminated string deserializer
  netlink: Fix leaks in netlink_parse_cmp()
  segtree: Fix for potential NULL-pointer deref in ei_insert()
  netlink: Avoid potential NULL-pointer deref in
    netlink_gen_payload_stmt()

 src/netlink_delinearize.c | 25 +++++++++++++++++--------
 src/netlink_linearize.c   |  2 +-
 src/segtree.c             | 18 +++++++++++++-----
 3 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.24.1

