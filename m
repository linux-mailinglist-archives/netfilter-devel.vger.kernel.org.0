Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52337146291
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jan 2020 08:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgAWHZj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jan 2020 02:25:39 -0500
Received: from relay.sw.ru ([185.231.240.75]:36706 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgAWHZj (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:25:39 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuWrl-0005wk-AV; Thu, 23 Jan 2020 10:25:25 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 0/4] netfilter: seq_file .next functions should increase
 position index
To:     coreteam@netfilter.org, netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Message-ID: <497a82c1-7b6a-adf4-a4ce-df46fe436aae@virtuozzo.com>
Date:   Thu, 23 Jan 2020 10:25:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In Aug 2018 NeilBrown noticed 
commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
"Some ->next functions do not increment *pos when they return NULL...
Note that such ->next functions are buggy and should be fixed. 
A simple demonstration is
   
dd if=/proc/swaps bs=1000 skip=1
    
Choose any block size larger than the size of /proc/swaps.  This will
always show the whole last line of /proc/swaps"

Described problem is still actual. If you make lseek into middle of last output line 
following read will output end of last line and whole last line once again.

$ dd if=/proc/swaps bs=1  # usual output
Filename				Type		Size	Used	Priority
/dev/dm-0                               partition	4194812	97536	-2
104+0 records in
104+0 records out
104 bytes copied

$ dd if=/proc/swaps bs=40 skip=1    # last line was generated twice
dd: /proc/swaps: cannot skip to specified offset
v/dm-0                               partition	4194812	97536	-2
/dev/dm-0                               partition	4194812	97536	-2 
3+1 records in
3+1 records out
131 bytes copied

There are lot of other affected files, I've found 30+ including
/proc/net/ip_tables_matches and /proc/sysvipc/*

This patch-set fixes files related to netfilter@ 

https://bugzilla.kernel.org/show_bug.cgi?id=206283

Vasily Averin (4):
  ct_cpu_seq_next should increase position index
  synproxy_cpu_seq_next should increase position index
  recent_seq_next should increase position index
  xt_mttg_seq_next should increase position index

 net/netfilter/nf_conntrack_standalone.c | 2 +-
 net/netfilter/nf_synproxy_core.c        | 2 +-
 net/netfilter/x_tables.c                | 6 +++---
 net/netfilter/xt_recent.c               | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.8.3.1

