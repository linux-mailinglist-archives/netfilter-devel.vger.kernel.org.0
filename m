Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8091EB7C3
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 20:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfJaTH7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 15:07:59 -0400
Received: from mail2.tootai.net ([78.46.82.189]:33928 "EHLO mail2.tootai.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfJaTH7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:07:59 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 15:07:58 EDT
Received: from mail1.tootai.net (localhost [127.0.0.1])
        by mail1.tootai.net (Postfix) with ESMTP id 48213603F26B
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 19:48:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tootai.net; s=mail;
        t=1572547696; bh=eXOPXFG5LFARtIdeOnoZnlhxuSnWEFAv9Xq8dzp72cA=;
        h=To:From:Subject:Date:From;
        b=gU/F817jb2Z9VcKBbqFBSp2SUtcB1JmjtvPy7Rg2/ENPUrWVTBeMxfxPkel1zq2R2
         Sl3DbsLT1GtILiEFgl5lYwSagH4VRQvDAkuRpd/CCDUyHrSymYdAM4jbGzTtd+2D5q
         oY7cE5lw5r/gVot4oybfbiyqZ8fMapnbKa/VSJGc=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on wwwmail9
X-Spam-Level: 
X-Spam-Status: No, score=-102.5 required=3.5 tests=ALL_TRUSTED,BAYES_00,
        T_DKIM_INVALID,USER_IN_WHITELIST autolearn=ham autolearn_force=no
        version=3.4.2
Received: from [192.168.10.4] (unknown [192.168.10.4])
        by mail1.tootai.net (Postfix) with ESMTPSA id 0F7D7603F11A
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 19:48:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tootai.net; s=mail;
        t=1572547696; bh=eXOPXFG5LFARtIdeOnoZnlhxuSnWEFAv9Xq8dzp72cA=;
        h=To:From:Subject:Date:From;
        b=gU/F817jb2Z9VcKBbqFBSp2SUtcB1JmjtvPy7Rg2/ENPUrWVTBeMxfxPkel1zq2R2
         Sl3DbsLT1GtILiEFgl5lYwSagH4VRQvDAkuRpd/CCDUyHrSymYdAM4jbGzTtd+2D5q
         oY7cE5lw5r/gVot4oybfbiyqZ8fMapnbKa/VSJGc=
To:     Netfilter list <netfilter-devel@vger.kernel.org>
From:   Daniel Huhardeaux <tech@tootai.net>
Subject: Nat redirect using map
Message-ID: <6ea6ecb5-99c5-5519-b689-8e1291df69cc@tootai.net>
Date:   Thu, 31 Oct 2019 19:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I have a map like this

map redirect_tcp {
                 type inet_service : inet_service
                 flags interval
                 elements = { 12345 : 12345, 36025 : smtp }
         }

and want to use nat redirect but it fail with unexpecting to, expecting 
EOF or semicolon. Here is the rule

nft add rule ip nat prerouting iif eth0 tcp dport map @redirect_tcp 
redirect to @redirect_tcp

How can I get this working ?

Other: when using dnat for forwarding, should I take care of forward rules ?

Example for this kind of rule from wiki:

nft add rule nat prerouting iif eth0 tcp dport { 80, 443 } dnat 
192.168.1.120

Thanks for any hint
-- 
TOOTAi Networks
