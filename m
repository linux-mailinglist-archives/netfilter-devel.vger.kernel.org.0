Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE82B7533
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Nov 2020 05:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgKREDC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Nov 2020 23:03:02 -0500
Received: from mail.redfish-solutions.com ([45.33.216.244]:48666 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbgKREDB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:03:01 -0500
Received: from [192.168.3.4] (174-27-108-50.bois.qwest.net [174.27.108.50] (may be forged))
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.15.2/8.15.2) with ESMTPSA id 0AI42upj320555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 21:02:57 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: Issues w/ db-ip country database
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <EC421C64-614D-40CC-B544-40DB2A657EE4@redfish-solutions.com>
Date:   Tue, 17 Nov 2020 21:02:56 -0700
Cc:     netfilter-devel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E9387BD8-079E-4E05-B964-4FA7986B47E8@redfish-solutions.com>
References: <8B419AF6-031F-4F6A-A3FB-3118780F6119@redfish-solutions.com>
 <2qp4q17-pqpo-2q0-24r0-q466sro3pp44@vanv.qr>
 <B6D36DF0-178A-4985-AB85-4BEE2AAD9116@redfish-solutions.com>
 <548ron6o-rq26-725-rqp4-r0p6n83r36r@vanv.qr>
 <EC421C64-614D-40CC-B544-40DB2A657EE4@redfish-solutions.com>
To:     Jan Engelhardt <jengelh@inai.de>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
X-Scanned-By: MIMEDefang 2.84 on 192.168.1.3
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org



> On Nov 17, 2020, at 1:32 PM, Philip Prindeville <philipp_subx@redfish-solutions.com> wrote:
> 
> 
>> On Nov 17, 2020, at 12:20 PM, Jan Engelhardt <jengelh@inai.de> wrote:
>> 
>> On Tuesday 2020-11-17 19:08, Philip Prindeville wrote:
>>>>> Many known blocks owned by Chinanet for instance, don’t show up as /11 or /13
>>>>> networks, but as dozens of /23 networks instead in China, the US, Japan, and
>>>>> Canada. Clearly not correct.
>>> 
>>> 183.128.0.0/11 is supposedly a single block of Chinanet, but the database
>>> shows it as being 329 subnets (164 supposedly in the US), again mostly /23’s
>>> and /22’s:
>>> 183.136.192.0,183.136.193.99,CN
>>> 183.136.193.100,183.136.193.255,US
>> 
>> 100 is not "nicely divisible" along a bit boundary, that's already a giveaway
>> that something is atypical.
>> Maybe it's a set of VPN endpoints (into China) for external 
>> companies registered with MIIT/PSB or something.
> 
> 
> So, what to do?  How to move forward?
> 
> I sent them a question about this over the weekend and I’m still waiting to hear back.
> 
> Given that people might use this data to block APT’s, I think the data should be something that doesn’t raise more questions than it answers...
> 
> 
>> 
>>> 212.174.0.0/15 supposedly is a single block of TurkTelecom, but the database
>>> shows it as being 296 subnets, mostly /23’s.
>> 
>> and to add icing, WHOIS has four entries for it.
>> 212.174.0.0/17 212.174.128.0/17 212.175.0.0/17 212.175.128.0/17
> 
> 
> Yeah, I don’t get that either.
> 


If anyone else is feeling uneasy about the reliability of the dbip-country-lite data, I’ve branched master of xtables-addons (on SF.net) and reverted the changes that made it use that database:

https://sourceforge.net/u/pprindeville/xtables-addons/ci/revert-to-maxmind/tree/

So you can use that until the dust settles and we figure out the discrepancies.

Thanks.

-Philip

