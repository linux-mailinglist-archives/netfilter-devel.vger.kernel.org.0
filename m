Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768FC31E26
	for <lists+netfilter-devel@lfdr.de>; Sat,  1 Jun 2019 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfFANXj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 1 Jun 2019 09:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbfFANXi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:23:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1AC27333;
        Sat,  1 Jun 2019 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395417;
        bh=mpK1R3CoQOBwdpjhvFcXxrFDFhjGjyoxehuKVzq5gmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CP4BNeUX9RGVDwKuYnMuXyR7Pbgczw7QueMFnyaNm3FJS7wDfjRHQLjkRfK7VkxYQ
         STdqZ1oXuk0mTFA4mZ2pOkZStnH/R3aCXg6Wl19LE2DGVHS0Qkam6Wdbj7+cxOsQcf
         k4LNwd3s2gA5lEeVP6EwStTA6W0Ju/pyfVt2Ta2E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Jankowski <shasta@toxcorp.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 052/141] netfilter: nf_conntrack_h323: restore boundary check correctness
Date:   Sat,  1 Jun 2019 09:20:28 -0400
Message-Id: <20190601132158.25821-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Jakub Jankowski <shasta@toxcorp.com>

[ Upstream commit f5e85ce8e733c2547827f6268136b70b802eabdb ]

Since commit bc7d811ace4a ("netfilter: nf_ct_h323: Convert
CHECK_BOUND macro to function"), NAT traversal for H.323
doesn't work, failing to parse H323-UserInformation.
nf_h323_error_boundary() compares contents of the bitstring,
not the addresses, preventing valid H.323 packets from being
conntrack'd.

This looks like an oversight from when CHECK_BOUND macro was
converted to a function.

To fix it, stop dereferencing bs->cur and bs->end.

Fixes: bc7d811ace4a ("netfilter: nf_ct_h323: Convert CHECK_BOUND macro to function")
Signed-off-by: Jakub Jankowski <shasta@toxcorp.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 1601275efe2d1..4c2ef42e189cb 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -172,7 +172,7 @@ static int nf_h323_error_boundary(struct bitstr *bs, size_t bytes, size_t bits)
 	if (bits % BITS_PER_BYTE > 0)
 		bytes++;
 
-	if (*bs->cur + bytes > *bs->end)
+	if (bs->cur + bytes > bs->end)
 		return 1;
 
 	return 0;
-- 
2.20.1

