Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765B32981CF
	for <lists+netfilter-devel@lfdr.de>; Sun, 25 Oct 2020 14:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416216AbgJYNQL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Oct 2020 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416222AbgJYNQI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Oct 2020 09:16:08 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9058CC0613D0
        for <netfilter-devel@vger.kernel.org>; Sun, 25 Oct 2020 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IorB3Bawoq7KGt7P/xlTc5lZN6CaFrb32Ct0awhryMw=; b=TpRAaIwyMvJzIROc1Gn3yjTGXM
        5FtBHDRXNdObD4kBOL6GO157mm7hg0UL0yU6RiDnQqJxpjQ/eZ4m9ppeLI79+jjB8Dw4lAiaz3bAh
        sEDy/YrhZDZWgFEv9/EqNjZgEDdYmRScabLC5kd2Byc7+TrZoXPcN7/J9y/ZP/ZruVQZVQOdko58C
        GkH9JZajPY+lQLNilpD8hoC5gmHX15K0k/+oXHdSXlXPvq7mtv0Qkju/c5bfV1TWpZCCwNphpqEje
        TjpSdphhngYztDr/VLIFteBNnHqslK8b9L2BzlgAAuhdtjTwHHWPp9DYeurkbCJan7b7v7QbxJxM0
        YYCMAidg==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kWfsU-0001SE-OA; Sun, 25 Oct 2020 13:16:07 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons v2 07/13] pknock: pknlusr: don't treat recv return value of zero as an error.
Date:   Sun, 25 Oct 2020 13:15:53 +0000
Message-Id: <20201025131559.920038-9-jeremy@azazel.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201025131559.920038-1-jeremy@azazel.net>
References: <20201025131559.920038-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

A return-value of zero is not an error, so there's no point calling
perror, but since we have not requested and don't expect a zero-length
datagram, we treat it as EOF and exit.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/pknock/pknlusr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/extensions/pknock/pknlusr.c b/extensions/pknock/pknlusr.c
index 9f11250510a1..2dd9ab7b9705 100644
--- a/extensions/pknock/pknlusr.c
+++ b/extensions/pknock/pknlusr.c
@@ -59,11 +59,14 @@ int main(void)
 
 		status = recv(sock_fd, nlmsg, nlmsg_size, 0);
 
-		if (status <= 0) {
+		if (status < 0) {
 			perror("recv()");
 			return 1;
 		}
 
+		if (status == 0)
+			break;
+
 		cn_msg = NLMSG_DATA(nlmsg);
 		pknock_msg = (struct xt_pknock_nl_msg *)(cn_msg->data);
 		ip = inet_ntop(AF_INET, &pknock_msg->peer_ip, ipbuf, sizeof(ipbuf));
-- 
2.28.0

