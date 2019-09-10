Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3CAF261
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Sep 2019 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfIJUt5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Sep 2019 16:49:57 -0400
Received: from mx1.riseup.net ([198.252.153.129]:41416 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfIJUt5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:49:57 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id F1BA11A2934;
        Tue, 10 Sep 2019 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1568148597; bh=bqcef9wN5c0ju6tikTCtvDmLljOccVkcf23Oh/CPlm4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XaRBsRJJ7aEYRPgp7nDBvZEGIaayW8QrPqUM6uXvQ773kTbsRBcRvjzTXGq/8cZ2k
         f4WkzwkmVGXZkmBCUfncCzUdjsyL8nuRJjz1E95Vut3BtRYz7fNcnBBTDp5Z3t6OM7
         i1wfvxP3dXRJLT6fvNqB/XPIY9Zq/YaL4fOzMXCE=
X-Riseup-User-ID: 5DFD2CC50CBB8174D03535C676C258A10F58F3892809B75767F3DCB7F5D9827A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 414941209E2;
        Tue, 10 Sep 2019 13:49:56 -0700 (PDT)
Subject: Re: [PATCH nft v3] src: add synproxy stateful object support
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <20190908193720.26163-1-ffmancera@riseup.net>
 <20190910204914.gimmpiuie74ouftg@salvia>
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
Message-ID: <02871f53-d3f6-6aff-5a1a-063f19c4a32e@riseup.net>
Date:   Tue, 10 Sep 2019 22:50:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190910204914.gimmpiuie74ouftg@salvia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On 9/10/19 10:49 PM, Pablo Neira Ayuso wrote:
> On Sun, Sep 08, 2019 at 09:37:21PM +0200, Fernando Fernandez Mancera wrote:
>> Add support for "synproxy" stateful object. For example (for TCP port 80 and
>> using maps with saddr):
>>
>> table ip foo {
>> 	synproxy https-synproxy {
>> 		mss 1460
>> 		wscale 7
>> 		timestamp sack-perm
>> 	}
>>
>> 	synproxy other-synproxy {
>> 		mss 1460
>> 		wscale 5
>> 	}
>>
>> 	chain bar {
>> 		tcp dport 80 synproxy name "https-synproxy"
>> 		synproxy name ip saddr map { 192.168.1.0/24 : "https-synproxy", 192.168.2.0/24 : "other-synproxy" }
>> 	}
>> }
> 
> Nice. Could you also add some tests for tests/py?
> 
> Thanks.
> 

Sure, thanks Pablo.
