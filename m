Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B860E75FF4
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jul 2019 09:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfGZHgv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 26 Jul 2019 03:36:51 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:20180 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfGZHgv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:36:51 -0400
Received: from [IPv6:2a01:e34:ec0c:ae81:259a:5cf4:cd92:2659] (unknown [IPv6:2a01:e34:ec0c:ae80:259a:5cf4:cd92:2659])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id 162F113F854;
        Fri, 26 Jul 2019 09:36:44 +0200 (CEST)
Subject: Re: [PATCH iptables]: restore legacy behaviour of iptables-restore
 when rules start with -4/-6
To:     Phil Sutter <phil@nwl.cc>
References: <f056f1bb-2a73-5042-740c-f2a16958deb0@free.fr>
 <20190725104035.GP22661@orbyte.nwl.cc>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
From:   Adel Belhouane <bugs.a.b@free.fr>
Message-ID: <fa2088a4-f147-4756-11a5-7105bfaabfff@free.fr>
Date:   Fri, 26 Jul 2019 09:36:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725104035.GP22661@orbyte.nwl.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello Phil,

Le 25/07/2019 à 12:40, Phil Sutter a écrit :
> 
> Would you mind creating a testcase in iptables/tests/shell? I guess
> testcases/ipt-restore is suitable, please have a look at
> 0003-restore-ordering_0 in that directory for an illustration of how we
> usually check results of *-restore calls.
> 

I moved the examples to two testcase files taking example on what you
suggested and resent a patch.

regards,
Adel
