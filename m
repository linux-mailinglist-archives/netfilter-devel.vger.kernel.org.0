Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA560DF7BC
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Oct 2019 23:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfJUVtY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Oct 2019 17:49:24 -0400
Received: from kadath.azazel.net ([81.187.231.250]:38476 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbfJUVtY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CApCPeS9xFSj4rn9qirpMbauKcc+9FQWYqKPdSqdR60=; b=GJd3coPYEQ7jJFrGse4GVoDi+q
        WYId+gvYe1erMB4VwsFRgXNNpWkOumPS9txVi9UtV6ioVp6ANB5UOif0lllUVaQBRSS3ZCZiWmIft
        c7oRtmXjRivgD2lDn57prgVJ2+ZnjQNt8uw6XDqlU/NTCbAjAZoyvpxVbnP2Xi4buPFE95vj7KJBs
        A/e+ZACnrvqORmkXEbWEh8UPy/ucpoH7cz8Ft+evTq7QuOCmMgYszIFHpey8nPglrGBSslHTNucqh
        7lW8NshTi24bUbmT2fKY2phr8V+ES/z/PVqn9lh8mXUvS1rFKdaOXwnCaARyoNa16FN1MVtYEDU+x
        lHyCg66g==;
Received: from ulthar.dreamlands ([192.168.96.2])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1iMfYI-00047s-N9; Mon, 21 Oct 2019 22:49:22 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v3 0/2] Add option to omit sets elements from listings.
Date:   Mon, 21 Oct 2019 22:49:20 +0100
Message-Id: <20191021214922.8943-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From https://bugzilla.netfilter.org/show_bug.cgi?id=1374:

  Listing an entire ruleset or a table with 'nft list ...' will also
  print all elements of all set definitions within the ruleset or
  requested table. Seeing the full set contents is not often necessary
  especially when requesting to see someone's ruleset for help and
  support purposes. It would be helpful if there was an option/flag for
  the nft tool to suppress set contents when listing.

This patch series implements the request by adding a new option: `-t`,
`--terse`.

Since v2:

  * changed the short option for `--numeric-time` from `-t` to `-T`;
  * used a new option (`-t`, `--terse`) instead of extending
    `--stateless`.

Since v1:

  * updated man-page and usage;
  * dropped 'dynamic' as a possible parameter-value.

Jeremy Sowden (2):
  src: use `-T` as the short option for `--numeric-time`.
  src: add --terse to suppress output of set elements.

 doc/libnftables.adoc           | 21 ++++++++++++---------
 doc/nft.txt                    |  6 +++++-
 include/nftables.h             |  5 +++++
 include/nftables/libnftables.h |  1 +
 src/main.c                     | 15 ++++++++++++---
 src/rule.c                     |  3 ++-
 6 files changed, 37 insertions(+), 14 deletions(-)

-- 
2.23.0

