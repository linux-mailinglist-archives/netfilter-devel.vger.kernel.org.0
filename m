Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745284FB9CD
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 Apr 2022 12:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbiDKKi0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Apr 2022 06:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbiDKKiZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:38:25 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D19326E3;
        Mon, 11 Apr 2022 03:36:09 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ndrOw-0005u3-Ne; Mon, 11 Apr 2022 12:36:06 +0200
Message-ID: <c28ed507-168e-e725-dddd-b81fadaf6aa5@leemhuis.info>
Date:   Mon, 11 Apr 2022 12:36:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Intermittent performance regression related to ipset between 5.10
 and 5.15
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Cc:     "U'ren, Aaron" <Aaron.U'ren@sony.com>,
        "Brown, Russell" <Russell.Brown@sony.com>,
        "Rueger, Manuel" <manuel.rueger@sony.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Florian Westphal <fw@strlen.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "McLean, Patrick" <Patrick.Mclean@sony.com>
References: <BY5PR13MB3604D24C813A042A114B639DEE109@BY5PR13MB3604.namprd13.prod.outlook.com>
 <5e56c644-2311-c094-e099-cfe0d574703b@leemhuis.info>
In-Reply-To: <5e56c644-2311-c094-e099-cfe0d574703b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649673369;08bb7d89;
X-HE-SMSGID: 1ndrOw-0005u3-Ne
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

[CCing netfilter and netfilter maintainers]

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

What up here? Was this regression report addressed? It looks like it
fell through the cracks to me.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot poke

On 16.03.22 10:17, Thorsten Leemhuis wrote:
> [TLDR: I'm adding the regression report below to regzbot, the Linux
> kernel regression tracking bot; all text you find below is compiled from
> a few templates paragraphs you might have encountered already already
> from similar mails.]
> 
> On 16.03.22 00:15, McLean, Patrick wrote:
>> When we upgraded from the 5.10 (5.10.61) series to the 5.15 (5.15.16) series, we encountered an intermittent performance regression that appears to be related to iptables / ipset. This regression was noticed on Kubernetes hosts that run kube-router and experience a high amount of churn to both iptables and ipsets. Specifically, when we run the nftables (iptables-1.8.7 / nftables-1.0.0) iptables wrapper xtables-nft-multi on the 5.15 series kernel, we end up getting extremely laggy response times when iptables attempts to lookup information on the ipsets that are used in the iptables definition. This issue isn’t reproducible on all hosts. However, our experience has been that across a fleet of ~50 hosts we experienced this issue on ~40% of the hosts. When the problem evidences, the time that it takes to run unrestricted iptables list commands like iptables -L or iptables-save gradually increases over the course of about 1 - 2 hours. Growing from less than a second to run, to taking sometimes over 2 minutes to run. After that 2 hour mark it seems to plateau and not grow any longer. Flushing tables or ipsets doesn’t seem to have any affect on the issue. However, rebooting the host does reset the issue. Occasionally, a machine that was evidencing the problem may no longer evidence it after being rebooted.
>>
>> We did try to debug this to find a root cause, but ultimately ran short on time. We were not able to perform a set of bisects to hopefully narrow down the issue as the problem isn’t consistently reproducible. We were able to get some straces where it appears that most of the time is spent on getsockopt() operations. It appears that during iptables operations, it attempts to do some work to resolve the ipsets that are linked to the iptables definitions (perhaps getting the names of the ipsets themselves?). Slowly that getsockopt request takes more and more time on affected hosts. Here is an example strace of the operation in question:
>>
>> 0.000074 newfstatat(AT_FDCWD, "/etc/nsswitch.conf", {st_mode=S_IFREG|0644, st_size=539, ...}, 0) = 0 <0.000017>
>> 0.000064 openat(AT_FDCWD, "/var/db/protocols.db", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory) <0.000017>
>> 0.000057 openat(AT_FDCWD, "/etc/protocols", O_RDONLY|O_CLOEXEC) = 4 <0.000013>
>> 0.000034 newfstatat(4, "", {st_mode=S_IFREG|0644, st_size=6108, ...}, AT_EMPTY_PATH) = 0 <0.000009>
>> 0.000032 lseek(4, 0, SEEK_SET)     = 0 <0.000008>
>> 0.000025 read(4, "# /etc/protocols\n#\n# Internet (I"..., 4096) = 4096 <0.000010>
>> 0.000036 close(4)                  = 0 <0.000008>
>> 0.000028 write(1, "ANGME7BF25 - [0:0]\n:KUBE-POD-FW-"..., 4096) = 4096 <0.000028>
>> 0.000049 socket(AF_INET, SOCK_RAW, IPPROTO_RAW) = 4 <0.000015>
>> 0.000032 fcntl(4, F_SETFD, FD_CLOEXEC) = 0 <0.000008>
>> 0.000024 getsockopt(4, SOL_IP, 0x53 /* IP_??? */, "\0\1\0\0\7\0\0\0", [8]) = 0 <0.000024>
>> 0.000046 getsockopt(4, SOL_IP, 0x53 /* IP_??? */, "\7\0\0\0\7\0\0\0KUBE-DST-VBH27M7NWLDOZIE"..., [40]) = 0 <0.109384>
>> 0.109456 close(4)                  = 0 <0.000022>
>>
>> On a host that is not evidencing the performance regression we normally see that operation take ~ 0.00001 as opposed to 0.109384.Additionally, hosts that were evidencing the problem we also saw high lock times with `klockstat` (unfortunately at the time we did not know about or run echo "0" > /proc/sys/kernel/kptr_restrict to get the callers of the below commands).
>>
>> klockstat -i 5 -n 10 (on a host experiencing the problem)
>> Caller   Avg Hold  Count   Max hold Total hold
>> b'[unknown]'  118490772     83  179899470 9834734132
>> b'[unknown]'  118416941     83  179850047 9828606138
>> # or somewhere later while iptables -vnL was running:
>> Caller   Avg Hold  Count   Max hold Total hold
>> b'[unknown]'  496466236     46 17919955720 22837446860
>> b'[unknown]'  496391064     46 17919893843 22833988950
>>
>> klockstat -i 5 -n 10 (on a host not experiencing the problem)
>> Caller   Avg Hold  Count   Max hold Total hold
>> b'[unknown]'     120316   1510   85537797  181677885
>> b'[unknown]'    7119070     24   85527251  170857690
> 
> Hi, this is your Linux kernel regression tracker.
> 
> Thanks for the report.
> 
> CCing the regression mailing list, as it should be in the loop for all
> regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> 
> To be sure below issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, my Linux kernel regression tracking bot:
> 
> #regzbot ^introduced v5.10..v5.15
> #regzbot title net: netfilter: Intermittent performance regression
> related to ipset
> #regzbot ignore-activity
> 
> If it turns out this isn't a regression, free free to remove it from the
> tracking by sending a reply to this thread containing a paragraph like
> "#regzbot invalid: reason why this is invalid" (without the quotes).
> 
> Reminder for developers: when fixing the issue, please add a 'Link:'
> tags pointing to the report (the mail quoted above) using
> lore.kernel.org/r/, as explained in
> 'Documentation/process/submitting-patches.rst' and
> 'Documentation/process/5.Posting.rst'. Regzbot needs them to
> automatically connect reports with fixes, but they are useful in
> general, too.
> 
> I'm sending this to everyone that got the initial report, to make
> everyone aware of the tracking. I also hope that messages like this
> motivate people to directly get at least the regression mailing list and
> ideally even regzbot involved when dealing with regressions, as messages
> like this wouldn't be needed then. And don't worry, if I need to send
> other mails regarding this regression only relevant for regzbot I'll
> send them to the regressions lists only (with a tag in the subject so
> people can filter them away). With a bit of luck no such messages will
> be needed anyway.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
