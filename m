Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D061811D7EE
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Dec 2019 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfLLUfv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Dec 2019 15:35:51 -0500
Received: from a3.inai.de ([88.198.85.195]:39958 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730834AbfLLUfv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:35:51 -0500
Received: by a3.inai.de (Postfix, from userid 25121)
        id D7FD658743FC0; Thu, 12 Dec 2019 21:35:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id D144E60C620DF;
        Thu, 12 Dec 2019 21:35:49 +0100 (CET)
Date:   Thu, 12 Dec 2019 21:35:49 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] main: allow for getopt parser from top-level scope
 only
In-Reply-To: <20191212183309.ecfvftcw3rxwm6ni@salvia>
Message-ID: <nycvar.YFH.7.76.1912122132300.29738@n3.vanv.qr>
References: <20191212171455.83382-1-pablo@netfilter.org> <20191212174535.GI20005@orbyte.nwl.cc> <nycvar.YFH.7.76.1912121926350.25751@n3.vanv.qr> <20191212183309.ecfvftcw3rxwm6ni@salvia>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Thursday 2019-12-12 19:33, Pablo Neira Ayuso wrote:
>> 
>> Or simply stop taking options after the first-non option.
>> This is declared POSIX behavior, and, for glibc, it only needs the
>> POSIXLY_CORRECT environment variable, which can be set ahead of
>> getopt()/getopt_long() call and unset afterwards again.
>
>I think we tried that already, IIRC it breaks: nft list ruleset -a
>which is in the test scripts.

Yes, it will need to be rewritten as `nft -a list ruleset`.

But.. you seem to be just fine with that, based on:

>The most sane approach from programmer perspective is to force users
>to place options upfront.
