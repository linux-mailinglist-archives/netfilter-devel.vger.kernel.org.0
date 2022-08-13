Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC5591A1D
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Aug 2022 14:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiHMMRP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 13 Aug 2022 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHMMRP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 13 Aug 2022 08:17:15 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Aug 2022 05:17:14 PDT
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36FD06DF97
        for <netfilter-devel@vger.kernel.org>; Sat, 13 Aug 2022 05:17:14 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 9599113E0E;
        Sat, 13 Aug 2022 15:11:59 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id C7E3F13E09;
        Sat, 13 Aug 2022 15:11:57 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 04AE23C043A;
        Sat, 13 Aug 2022 15:11:54 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 27DCBmNp019049;
        Sat, 13 Aug 2022 15:11:51 +0300
Date:   Sat, 13 Aug 2022 15:11:48 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
cc:     netfilter-devel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        lvs-devel@vger.kernel.org
Subject: Re: [RFC PATCH nf-next] netfilter: ipvs: Divide estimators into
 groups
In-Reply-To: <20220812103459.GA7521@incl>
Message-ID: <f1657ace-59fb-7265-faf8-8a1a26aaf560@ssi.bg>
References: <20220812103459.GA7521@incl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


	Hello,

On Fri, 12 Aug 2022, Jiri Wiesner wrote:

> The calculation of rate estimates for IPVS services and destinations will
> cause an increase in scheduling latency to hundreds of milliseconds when
> the number of estimators reaches tens of thousands or more. This issue has
> been reported upstream [1]. Design changes to the algorithm to compute the
> estimates were proposed in the same email thread.
> 
> By implementing some of the proposed design changes, this patch seeks to
> address the latency issue by dividing the estimators into groups for which
> estimates are calculated in a 2-second interval (same as before). Each of
> the groups is processed once in each 2-second interval. Instead of
> allocating an array of lists, groups are identified by their group_id,
> which has the advantage that estimators can stay in the same list to which
> they have been added by ip_vs_start_estimator(). The implementation of
> estimator grouping is able to scale up with an increasing number of
> estimators as well as scale down when estimators are being removed.
> The changes to group size can be monitored with dynamic debugging:
> echo 'file net/netfilter/ipvs/ip_vs_est.c +pfl' >> /sys/kernel/debug/dynamic_debug/control
> 
> Rebalacing of estimator groups is implemented and can be triggered only
> after all the calculations for a 2-second interval have finished. After a
> limit is exceeded, adding or removing estimators will triger rebalacing,
> which will cause estimates to be inaccurate in the next 2-second interval.
> For example, removing estimators that results in the removal of an entire
> group will shorten the time interval used for computing rates, which will
> lead to the rates being underestimated in the next 2-second interval.
> 
> Testing was carried out on a 2-socket machine with Intel Xeon Gold 6326
> CPUs (64 logical CPUs). Tests with up to 600,000 estimators were
> successfully completed. The expectation is that, given the current default
> limits, the implementation can handle 150,000 estimators on most machines
> in use today. In a test with 100,000 estimators, the default group size of
> 1024 estimators resulted in the processing time for one group to be circa
> 2.3 milliseconds and a timer period of 5 jiffies. Despite estimators being
> added or removed throughout most of the test, the overhead of
> ip_vs_estimator_rebalance() was less than 10% of the overhead of
>  estimation_timer():
>      7.66%        124093  swapper          [kernel.kallsyms]         [k] intel_idle
>      2.86%         14296  ipvsadm          [kernel.kallsyms]         [k] native_queued_spin_lock_slowpath
>      2.64%         16827  ipvsadm          [kernel.kallsyms]         [k] ip_vs_genl_parse_service
>      2.15%         18457  ipvsadm          libc-2.31.so              [.] _dl_addr
>      2.08%          4562  ipvsadm          [kernel.kallsyms]         [k] ip_vs_genl_dump_services
>      2.06%         18326  ipvsadm          ld-2.31.so                [.] do_lookup_x
>      1.78%         17251  swapper          [kernel.kallsyms]         [k] estimation_timer
> ...
>      0.14%           855  swapper          [kernel.kallsyms]         [k] ip_vs_estimator_rebalance
> 
> The intention is to develop this RFC patch into a short series addressing
> the design changes proposed in [1]. Also, after moving the rate estimation
> out of softirq context, the whole estimator list could be processed
> concurrently - more than one work item would be used.
> 
> [1] https://lore.kernel.org/netdev/D25792C1-1B89-45DE-9F10-EC350DC04ADC@gmail.com
> 
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>

	Other developers tried solutions with workqueues
but so far we don't see any results. Give me some days, may be
I can come up with solution that uses kthread(s) to allow later
nice/cpumask cfg tuning and to avoid overload of the system
workqueues.

Regards

--
Julian Anastasov <ja@ssi.bg>

