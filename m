Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CDD7F5CC
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Aug 2019 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfHBLMM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Aug 2019 07:12:12 -0400
Received: from vxsys-smtpclusterma-03.srv.cat ([46.16.60.199]:52965 "EHLO
        vxsys-smtpclusterma-03.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731048AbfHBLML (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:12:11 -0400
Received: from [192.168.4.111] (242.red-83-48-67.staticip.rima-tde.net [83.48.67.242])
        by vxsys-smtpclusterma-03.srv.cat (Postfix) with ESMTPA id 03EC624219;
        Fri,  2 Aug 2019 13:12:08 +0200 (CEST)
Subject: Re: [PATCH v6] meta: Introduce new conditions 'time', 'day' and
 'hour'
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
References: <20190802071038.5509-1-a@juaristi.eus>
 <20190802104502.yeunepvge6ohnjsm@breakpoint.cc>
From:   Ander Juaristi <a@juaristi.eus>
Message-ID: <20887110-0683-8e2a-ca5f-2a50f1e2e535@juaristi.eus>
Date:   Fri, 2 Aug 2019 13:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190802104502.yeunepvge6ohnjsm@breakpoint.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sorry, my bad. The machine I ran the tests on didn't have the patched 
libnftnl so all of them passed. I'll check again.

On 2/8/19 12:45, Florian Westphal wrote:
> Ander Juaristi <a@juaristi.eus> wrote:
>> --- a/tests/py/ip/meta.t.payload
>> +++ b/tests/py/ip/meta.t.payload
>> @@ -1,3 +1,87 @@
>> +# meta time "1970-05-23 21:07:14" drop
>> +ip meta-test input
>> +  [ meta load unknown => reg 1 ]
> 
> This "unknown" should not exist anymore after your libnftnl patch.
> 
