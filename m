Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94BAA136D1B
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jan 2020 13:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgAJMdO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Jan 2020 07:33:14 -0500
Received: from kadath.azazel.net ([81.187.231.250]:39614 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgAJMdO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cBjhdH6avh6t4Ngu3erkX/Q9uvAPML/2OvJMUvN73t0=; b=gCWiATaOL5Ecn1UWilevWn7692
        yMN/eKvjDUOk6sD6L8zedMZr9LqbmdD71W+p+Dnt8/1nZ/WGmpeLxBlecMQqKS1AVxbAbDcpz2SpZ
        qVGupuccZ22ilAbi8IcVSEbTcY3kotT+DfHZQAPXKvkOrm3D5v8SHBJjD9/3iSp5aZTUJqybqZfEb
        9TBCaOAYPbC7+IJkMD+KruooIh92/F3JyD47xII+/nbOpUY4G6E9uJdEDF7ozW+VDFYDm4MEbFhTu
        zhHkUzTTcn8cZwWnJ3QW9Fi1ppZLL6iSPffZcmzx1TMI/0pAPUa1tgK2CDPUPnHbN458bSFT7rDNl
        a/+7EKJQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1iptTU-0003by-T7
        for netfilter-devel@vger.kernel.org; Fri, 10 Jan 2020 12:33:12 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 0/3] netfilter: nft_bitwise: shift support
Date:   Fri, 10 Jan 2020 12:33:09 +0000
Message-Id: <20200110123312.106438-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The connmark xtables extension supports bit-shifts.  Add support for
shifts to nft_bitwise in order to allow nftables to do likewise, e.g.:

  nft add rule t c oif lo ct mark set meta mark << 8 | 0xab
  nft add rule t c iif lo meta mark & 0xff 0xab ct mark set meta mark >> 8

There are a couple of preliminary tidying-up patches first.

Jeremy Sowden (3):
  netfilter: nf_tables: white-space fixes.
  netfilter: bitwise: replace gotos with returns.
  netfilter: bitwise: add support for shifts.

 include/uapi/linux/netfilter/nf_tables.h |  9 ++-
 net/netfilter/nft_bitwise.c              | 97 ++++++++++++++++++++----
 net/netfilter/nft_set_bitmap.c           |  4 +-
 net/netfilter/nft_set_hash.c             |  2 +-
 4 files changed, 94 insertions(+), 18 deletions(-)

-- 
2.24.1

