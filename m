Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6EF1CE3
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Nov 2019 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfKFR4C (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Nov 2019 12:56:02 -0500
Received: from mail1.tootai.net ([213.239.227.108]:45622 "EHLO
        mail1.tootai.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfKFR4C (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:56:02 -0500
Received: from mail1.tootai.net (localhost [127.0.0.1])
        by mail1.tootai.net (Postfix) with ESMTP id 90A9B6019743
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Nov 2019 18:55:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tootai.net; s=mail;
        t=1573062957; bh=lEGKcG4G1V0B1kg6cAtaDUDxzVLYLHHEVcNGvLZ4LBk=;
        h=To:From:Subject:Date:From;
        b=sNXwe+AgDeg/wDIa2D4mrpocNZHrjEw7gy7Pox8caqI0JOdN7SYlhugmjNESG2Eov
         /5f+cq2rOy4RGJQbCFbFrYI6pEyLnJjk1pkgyVC8iKh4GUaeSBybexWZRsMZ8dB9UD
         f3VXV3Zv0XXwBnbr2WpTas6G53bqynD2RaQ2N9N0=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on wwwmail9
X-Spam-Level: 
X-Spam-Status: No, score=-102.5 required=3.5 tests=ALL_TRUSTED,BAYES_00,
        T_DKIM_INVALID,USER_IN_WHITELIST autolearn=ham autolearn_force=no
        version=3.4.2
Received: from [192.168.10.4] (unknown [192.168.10.4])
        by mail1.tootai.net (Postfix) with ESMTPSA id 56ADD6000084
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Nov 2019 18:55:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tootai.net; s=mail;
        t=1573062957; bh=lEGKcG4G1V0B1kg6cAtaDUDxzVLYLHHEVcNGvLZ4LBk=;
        h=To:From:Subject:Date:From;
        b=sNXwe+AgDeg/wDIa2D4mrpocNZHrjEw7gy7Pox8caqI0JOdN7SYlhugmjNESG2Eov
         /5f+cq2rOy4RGJQbCFbFrYI6pEyLnJjk1pkgyVC8iKh4GUaeSBybexWZRsMZ8dB9UD
         f3VXV3Zv0XXwBnbr2WpTas6G53bqynD2RaQ2N9N0=
To:     Netfilter list <netfilter-devel@vger.kernel.org>
From:   Daniel Huhardeaux <tech@tootai.net>
Subject: ipv6 forward rule after prerouting - Howto
Message-ID: <eb91d7f8-e344-c697-b2e0-ff4fb77245b2@tootai.net>
Date:   Wed, 6 Nov 2019 18:55:56 +0100
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

Hello,

I setup prerouting rules with maps like

chain prerouting {
    type nat hook prerouting priority 0; policy accept;
    iif "ens3" ip6 saddr . tcp dport vmap @blacklist_tcp
    if "ens3" ip6 saddr . udp dport vmap @blacklist_udp
    dnat to tcp dport map @fwdtoip_tcp:tcp dport map @fwdtoport_tcp
    dnat to udp dport map @fwdtoip_udp:udp dport map @fwdtoport_udp
    ip6 daddr 2a01:729:16e:10::9998 redirect to :tcp dport map @redirect_tcp
    ip6 daddr 2a01:729:16e:10::9998 redirect to :udp dport map @redirect_udp
    ct status dnat accept
    }

Default behavior in ip6 filter forward table is to drop. This means that 
my above rules are blocked, I see (u18srv being the machine who will 
forward the traffic to another one):

18:32:00.476524 IP6 <hostname>.41174 > u18srv.12345: Flags [S], seq 
126955234, win 28640, options [mss 1432,sackOK,TS val 2255777795 ecr 
0,nop,wscale 7], length 0 
 

18:32:08.668468 IP6 <hostname>.41174 > u18srv.12345: Flags [S], seq 
126955234, win 28640, options [mss 1432,sackOK,TS val 2255785986 ecr 
0,nop,wscale 7], length 0
18:32:24.796392 IP6 <hostname>.41174 > u18srv.12345: Flags [S], seq 
126955234, win 28640, options [mss 1432,sackOK,TS val 2255802114 ecr 
0,nop,wscale 7], length 0

Now if I change my default value to accept for ip6 filter forward table, 
all is good.

Question: how can I add forward rule to filter table using the existing 
maps which are defined in nat tables ? Other solution ?

I thought that ct status dnat accept was the key to archieve my goal, 
seems not :(

Thanks for any hint

-- 
Daniel
TOOTAi Networks
