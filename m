Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD06F2AA8
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Nov 2019 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfKGJaD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 7 Nov 2019 04:30:03 -0500
Received: from mail1.tootai.net ([213.239.227.108]:54068 "EHLO
        mail1.tootai.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGJaD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:30:03 -0500
Received: from mail1.tootai.net (localhost [127.0.0.1])
        by mail1.tootai.net (Postfix) with ESMTP id 4BD6D6027A25
        for <netfilter-devel@vger.kernel.org>; Thu,  7 Nov 2019 10:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tootai.net; s=mail;
        t=1573119000; bh=Z3HM63rW218CeKNjJ7qNnTHNRmz1u8Uk9Z4hCh0Rb2Y=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=YVek2lBo2WWVfTj0zmpcKRl8IRfQxqrN2U+J8QL3L+CqDIKATRqHE+XZvd4yWpSyu
         xXj/x/5fqjuxldUMfy/f6zBG4kVUi5+zi2jlzFmpq2sR65gUEkWV2R0X4DIYh9BI40
         99sjnJRi6hOsf8QpqtbXCYEX5dxw7Y/BeycwKF/U=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on wwwmail9
X-Spam-Level: 
X-Spam-Status: No, score=-102.5 required=3.5 tests=ALL_TRUSTED,BAYES_00,
        T_DKIM_INVALID,USER_IN_WHITELIST autolearn=ham autolearn_force=no
        version=3.4.2
Received: from [192.168.10.4] (unknown [192.168.10.4])
        by mail1.tootai.net (Postfix) with ESMTPSA id 0F56F6019743
        for <netfilter-devel@vger.kernel.org>; Thu,  7 Nov 2019 10:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tootai.net; s=mail;
        t=1573119000; bh=Z3HM63rW218CeKNjJ7qNnTHNRmz1u8Uk9Z4hCh0Rb2Y=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=YVek2lBo2WWVfTj0zmpcKRl8IRfQxqrN2U+J8QL3L+CqDIKATRqHE+XZvd4yWpSyu
         xXj/x/5fqjuxldUMfy/f6zBG4kVUi5+zi2jlzFmpq2sR65gUEkWV2R0X4DIYh9BI40
         99sjnJRi6hOsf8QpqtbXCYEX5dxw7Y/BeycwKF/U=
Subject: Re: ipv6 forward rule after prerouting - Howto
To:     Netfilter list <netfilter-devel@vger.kernel.org>
References: <eb91d7f8-e344-c697-b2e0-ff4fb77245b2@tootai.net>
 <20191106185022.GT15063@orbyte.nwl.cc>
From:   Daniel Huhardeaux <tech@tootai.net>
Message-ID: <6f7a8454-ceff-bd21-e18d-5bd959aa73bb@tootai.net>
Date:   Thu, 7 Nov 2019 10:29:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106185022.GT15063@orbyte.nwl.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Le 06/11/2019 à 19:50, Phil Sutter a écrit :
> Hi,
> 
> On Wed, Nov 06, 2019 at 06:55:56PM +0100, Daniel Huhardeaux wrote:
>> Hello,
>>
>> I setup prerouting rules with maps like
>>
>> chain prerouting {
>>      type nat hook prerouting priority 0; policy accept;
>>      iif "ens3" ip6 saddr . tcp dport vmap @blacklist_tcp
>>      if "ens3" ip6 saddr . udp dport vmap @blacklist_udp
>>      dnat to tcp dport map @fwdtoip_tcp:tcp dport map @fwdtoport_tcp
>>      dnat to udp dport map @fwdtoip_udp:udp dport map @fwdtoport_udp
>>      ip6 daddr 2a01:729:16e:10::9998 redirect to :tcp dport map @redirect_tcp
>>      ip6 daddr 2a01:729:16e:10::9998 redirect to :udp dport map @redirect_udp
>>      ct status dnat accept
>>      }
>>
>> Default behavior in ip6 filter forward table is to drop. This means that
>> my above rules are blocked, I see (u18srv being the machine who will
>> forward the traffic to another one):
>>
>> 18:32:00.476524 IP6 <hostname>.41174 > u18srv.12345: Flags [S], seq
>> 126955234, win 28640, options [mss 1432,sackOK,TS val 2255777795 ecr
>> 0,nop,wscale 7], length 0
>>   
>>
>> 18:32:08.668468 IP6 <hostname>.41174 > u18srv.12345: Flags [S], seq
>> 126955234, win 28640, options [mss 1432,sackOK,TS val 2255785986 ecr
>> 0,nop,wscale 7], length 0
>> 18:32:24.796392 IP6 <hostname>.41174 > u18srv.12345: Flags [S], seq
>> 126955234, win 28640, options [mss 1432,sackOK,TS val 2255802114 ecr
>> 0,nop,wscale 7], length 0
>>
>> Now if I change my default value to accept for ip6 filter forward table,
>> all is good.
>>
>> Question: how can I add forward rule to filter table using the existing
>> maps which are defined in nat tables ? Other solution ?
>>
>> I thought that ct status dnat accept was the key to archieve my goal,
>> seems not :(
>>
>> Thanks for any hint
> 
> Please be aware that 'accept' verdict will only stop the packet from
> traversing the current chain and any later chain may still drop the
> packet. Only 'drop' verdict is final in that sense.

This I understood

> 
> So regarding your problem, I guess you have to add the 'ct state' based
> accept rule to forward chain to prevent the drop policy to affect the
> packet. Your prerouting chain already has an accept policy, so explicit
> accepting shouldn't be needed.

I set again the default policy to drop and add the state new to the 
existing established,related ones. It's working too.

What I would like is to authorized state new _only_ for traffic going to 
ip and port which are setted in maps. Feasable ?

BTW, I just discover that my above redirect rules are not working, eg 
redirect port 12345 to port 25 failed with same tcpdump output as above. 
Any idea why ?

-- 
Daniel
TOOTAi Networks
