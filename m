Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 656C150BC1
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Jun 2019 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfFXNUR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Jun 2019 09:20:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbfFXNUR (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:20:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19D477FDCC;
        Mon, 24 Jun 2019 13:20:17 +0000 (UTC)
Received: from epycfail.redhat.com (unknown [10.36.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E061A608A6;
        Mon, 24 Jun 2019 13:20:15 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     Chen Yi <yiche@redhat.com>, netfilter-devel@vger.kernel.org
Subject: [PATCH 0/2] ipset: Two fixes for destination MAC address matches in ip,mac types
Date:   Mon, 24 Jun 2019 15:20:10 +0200
Message-Id: <cover.1561381646.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 24 Jun 2019 13:20:17 +0000 (UTC)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Commit 8cc4ccf58379 ("ipset: Allow matching on destination MAC address for
mac and ipmac sets"), ipset.git commit 1543514c46a7, properly allows
destination matching for hash:mac set types, but missed to remove the
previous restriction for type hash:ip,mac and introduced an obvious mistake
in both bitmap:ip,mac and hash:ip,mac.

Drop the left-over check and correct the mistake, to fix the issue reported
by Chen Yi.

Stefano Brivio (2):
  ipset: Actually allow destination MAC address for hash:ip,mac sets too
  ipset: Copy the right MAC address in bitmap:ip,mac and hash:ip,mac
    sets

 kernel/net/netfilter/ipset/ip_set_bitmap_ipmac.c | 2 +-
 kernel/net/netfilter/ipset/ip_set_hash_ipmac.c   | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.20.1

