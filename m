Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42249A837
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Aug 2019 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfHWHIw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Aug 2019 03:08:52 -0400
Received: from vxsys-smtpclusterma-03.srv.cat ([46.16.60.199]:45617 "EHLO
        vxsys-smtpclusterma-03.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731077AbfHWHIw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:08:52 -0400
Received: from [192.168.4.111] (242.red-83-48-67.staticip.rima-tde.net [83.48.67.242])
        by vxsys-smtpclusterma-03.srv.cat (Postfix) with ESMTPA id 6284822D74;
        Fri, 23 Aug 2019 09:08:48 +0200 (CEST)
Subject: Re: [PATCH nft v8 2/2] meta: Introduce new conditions 'time', 'day'
 and 'hour'
To:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <20190821151802.6849-1-a@juaristi.eus>
 <20190821151802.6849-2-a@juaristi.eus> <20190821162341.GB20113@breakpoint.cc>
 <20190821205055.dss3wfiv4pogyhjl@salvia>
 <20190821210417.GD20113@breakpoint.cc>
From:   Ander Juaristi <a@juaristi.eus>
Message-ID: <f7b2dec4-d58e-e65b-296a-11061b4af90f@juaristi.eus>
Date:   Fri, 23 Aug 2019 09:08:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190821210417.GD20113@breakpoint.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 21/8/19 23:04, Florian Westphal wrote:
>>>
>>> Pablo, please see this "-t" option -- should be just re-use -n instead?
>>>
>>> Other than this, this patch looks good and all tests pass for me.
>>
>> this should be printed numerically with -n (global switch to disable
>> literal printing).
>>
>> Then, -t could be added for disabling literal in a more fine grain, as
>> Phil suggest time ago with other existing options that are similar to
>> this one.
> 
> Ander, would you mind respinning this once more and excluding the -t
> option?  You can reuse -n (OPT_NUMERIC) to print raw time values for
> the time being.
> 

You mean removing the -t option altogether?

Okay, I'll send v9 today after lunch.
