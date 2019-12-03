Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27D510FF28
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Dec 2019 14:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCNsz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Dec 2019 08:48:55 -0500
Received: from a3.inai.de ([88.198.85.195]:33706 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfLCNsz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:48:55 -0500
Received: by a3.inai.de (Postfix, from userid 25121)
        id B912A59F48FDA; Tue,  3 Dec 2019 14:48:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id B286261CAB0D2;
        Tue,  3 Dec 2019 14:48:53 +0100 (CET)
Date:   Tue, 3 Dec 2019 14:48:53 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
cc:     Phil Sutter <phil@netfilter.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [ANNOUNCE] iptables 1.8.4 release
In-Reply-To: <902f6259-1886-b672-f53d-436b2250181c@netfilter.org>
Message-ID: <nycvar.YFH.7.76.1912031446420.25570@n3.vanv.qr>
References: <20191202170121.GB10243@orbyte.nwl.cc> <902f6259-1886-b672-f53d-436b2250181c@netfilter.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Tuesday 2019-12-03 14:28, Arturo Borrero Gonzalez wrote:
>On 12/2/19 6:01 PM, Phil Sutter wrote:
>> Hi!
>> 
>> The Netfilter project proudly presents:
>> 
>> iptables 1.8.4
>> 
>> This release contains the following fixes and enhancements:
>> 
>> libiptc:
>>  - Generic libiptc.so shared object is no longer built, likely all users
>>    link to libip4tc.so or libip6tc.so directly.
>> 
>
>There are many users of libiptc.h, i.e:
>
>#include <libiptc/libiptc.h>
>
>What is the best way to do that now?

Still #include <libiptc/libiptc.h>.

Just with

	gcc $(pkg-config xtables --cflags) xyz.c -lip4tc or -lip6tc

instead of

	gcc xyz.c -liptc
