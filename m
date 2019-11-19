Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7736102295
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 Nov 2019 12:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfKSLG1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 19 Nov 2019 06:06:27 -0500
Received: from vxsys-smtpclusterma-04.srv.cat ([46.16.61.152]:43177 "EHLO
        vxsys-smtpclusterma-04.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfKSLG1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:06:27 -0500
Received: from webmail.juaristi.eus (unknown [10.40.17.4])
        by vxsys-smtpclusterma-04.srv.cat (Postfix) with ESMTPA id E6E98242F2;
        Tue, 19 Nov 2019 12:06:23 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 19 Nov 2019 12:06:23 +0100
From:   Ander Juaristi <a@juaristi.eus>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tests/py: Set a fixed timezone in nft-test.py
Reply-To: a@juaristi.eus
Mail-Reply-To: a@juaristi.eus
In-Reply-To: <20191118183459.qkqztuc5pn4fezzn@salvia>
References: <20191116213218.14698-1-phil@nwl.cc>
 <20191118183459.qkqztuc5pn4fezzn@salvia>
Message-ID: <db71e3276085bccce877215254bbfc21@juaristi.eus>
X-Sender: a@juaristi.eus
User-Agent: Roundcube Webmail
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

El 2019-11-18 19:34, Pablo Neira Ayuso escribió:
> Hi Phil,
> 
> On Sat, Nov 16, 2019 at 10:32:18PM +0100, Phil Sutter wrote:
>> Payload generated for 'meta time' matches depends on host's timezone 
>> and
>> DST setting. To produce constant output, set a fixed timezone in
>> nft-test.py. Choose UTC-2 since most payloads are correct then, adjust
>> the remaining two tests.
> 
> This means that the ruleset listing for the user changes when daylight
> saving occurs, right? Just like it happened to our tests.

It shouldn't, as the date is converted to a timestamp that doesn't take 
DST into account (using timegm(3), which is Linux-specific).

The problem is that payloads are hard-coded in the tests.

Correct me if I'm missing something.

> 
> Thanks.
