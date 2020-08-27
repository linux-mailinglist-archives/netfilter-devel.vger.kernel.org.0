Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BBC2549E0
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Aug 2020 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH0PuV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Aug 2020 11:50:21 -0400
Received: from smtp-out-3.tiscali.co.uk ([62.24.135.131]:56185 "EHLO
        smtp-out-3.tiscali.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgH0PuV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:50:21 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2020 11:50:20 EDT
Received: from nabal.armitage.org.uk ([92.27.6.192])
        by smtp.talktalk.net with SMTP
        id BK2Uk8ypqyfmMBK2VkWRpU; Thu, 27 Aug 2020 16:42:11 +0100
X-Originating-IP: [92.27.6.192]
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
        by nabal.armitage.org.uk (Postfix) with ESMTP id 7B0832E3577
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Aug 2020 16:42:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
         h=content-transfer-encoding:mime-version:user-agent
        :content-type:content-type:date:date:from:from:subject:subject
        :message-id:received; s=20200110; t=1598542920; x=1599406921;
         bh=QE7MghN8errV8sNavxcm90HGgChb2RO/Meq7apSgKC8=; b=do7wjjW31Lvw
        u0t3wPyJkjXjn8W/pnLb9cUCYonW+F27HiDj0g+b/ay22ofgInOAQ86hdEb2vcWY
        hIfN5iuIDpvdK+1oBeonhUtqJOv3pkcXUHXGnhIg7ACR4dfbLCYi0a66fjZv6aRC
        kC9H/Q0AttKughEgC+5IsZcBIATLjoc=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from samson.armitage.org.uk (samson.armitage.org.uk [IPv6:2001:470:69dd:35::210])
        by nabal.armitage.org.uk (Postfix) with ESMTPSA id 62DDA2E3572
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Aug 2020 16:42:00 +0100 (BST)
Message-ID: <f9bc9e191b03728fe233ca7a75fdc40ede0fde8e.camel@armitage.org.uk>
Subject: [PATCH] netfilter: nftables: fix documentation for dup statement
From:   Quentin Armitage <quentin@armitage.org.uk>
To:     netfilter-devel@vger.kernel.org
Date:   Thu, 27 Aug 2020 16:42:00 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEsHdV4meuKZWlPwtUu8DXbXMtVv5o5JwhFruVdXC72grqbCWKktc/eJOOjgiPhqxa2NA2Li3gH5GYZgJXTdVosZ6sTpIzq73dc6y36BB74WduLJ42N6
 qEVsa8wNtSJrGSugmUpGnqJmKscVH952Sk6hev04l9yTq5jOYH5muBVb1TiDpSoTzm7Z4TUC6ZiIkKxazIJY9NutLdotrJe5bUU=
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


The dup statement requires an address, and the device is optional,
not the other way round.

Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
---
 doc/statements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/statements.txt b/doc/statements.txt
index 9155f286..835db087 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -648,7 +648,7 @@ The dup statement is used to duplicate a packet and send the
copy to a different
 destination.
 
 [verse]
-*dup to* 'device'
+*dup to* 'address'
 *dup to* 'address' *device* 'device'
 
 .Dup statement values
-- 
2.25.4


