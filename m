Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1226B1DD
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2019 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbfGPW32 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Jul 2019 18:29:28 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44604 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbfGPW32 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:29:28 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 77AF91A0E92;
        Tue, 16 Jul 2019 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1563316167; bh=8CJAw+k03k6DJHUt4qPGba6hdApm/fmJ1AsbTWwLeXo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iz7/SJ/mas3VBtMJjs9wozjD6+lirrhiXzA45AeqWvELdE2aBzUfS1ect1VUayL44
         XG1apVbg/3Yi9yjIx7df3WavsgK6Cekb8IeqeG+KO7OsoQ7kbZYezyjIWl80eRdS2r
         a2dMqNEBwd/Y9HkesJZD9jA2eHzIaYABDgS0TrjA=
X-Riseup-User-ID: 1B8EE526EFE21BDFE7C7F454FEF9B674A5C81767A2310D4254195B9B1F1B8633
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id D3F7B2230FB;
        Tue, 16 Jul 2019 15:29:25 -0700 (PDT)
Subject: Re: [PATCH nft] evaluate: bogus error when refering to existing
 non-base chain
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
References: <20190716115120.21710-1-pablo@netfilter.org>
 <20190716164711.GF1628@orbyte.nwl.cc>
 <63707D89-2251-4B96-BE53-880E12FF0F6A@riseup.net>
 <20190716180004.dwueos7c4yn75udi@breakpoint.cc>
 <20190716181253.dtmvpgqiykgx563m@salvia>
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
Openpgp: preference=signencrypt
Message-ID: <f272ea4e-29ca-0e04-d2da-53d7555f27d6@riseup.net>
Date:   Wed, 17 Jul 2019 00:29:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190716181253.dtmvpgqiykgx563m@salvia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On 7/16/19 8:12 PM, Pablo Neira Ayuso wrote:
> On Tue, Jul 16, 2019 at 08:00:04PM +0200, Florian Westphal wrote:
>> Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
>>> El 16 de julio de 2019 18:47:11 CEST, Phil Sutter <phil@nwl.cc> escribió:
>>>> Hi Pablo,
>>>>
>>>> On Tue, Jul 16, 2019 at 01:51:20PM +0200, Pablo Neira Ayuso wrote:
>>>> [...]
>>>>> diff --git a/src/evaluate.c b/src/evaluate.c
>>>>> index f95f42e1067a..cd566e856a11 100644
>>>>> --- a/src/evaluate.c
>>>>> +++ b/src/evaluate.c
>>>>> @@ -1984,17 +1984,9 @@ static int stmt_evaluate_verdict(struct
>>>> eval_ctx *ctx, struct stmt *stmt)
>>>>>  	case EXPR_VERDICT:
>>>>>  		if (stmt->expr->verdict != NFT_CONTINUE)
>>>>>  			stmt->flags |= STMT_F_TERMINAL;
>>>>> -		if (stmt->expr->chain != NULL) {
>>>>> -			if (expr_evaluate(ctx, &stmt->expr->chain) < 0)
>>>>> -				return -1;
>>>>> -			if ((stmt->expr->chain->etype != EXPR_SYMBOL &&
>>>>> -			    stmt->expr->chain->etype != EXPR_VALUE) ||
>>>>> -			    stmt->expr->chain->symtype != SYMBOL_VALUE) {
>>>>> -				return stmt_error(ctx, stmt,
>>>>> -						  "invalid verdict chain expression %s\n",
>>>>> -						  expr_name(stmt->expr->chain));
>>>>> -			}
>>>>> -		}
>>>>
>>>> According to my logs, this bit was added by Fernando to cover for
>>>> invalid variable values[1]. So I fear we can't just drop this check.
>>>>
>>>> Cheers, Phil
>>>>
>>>> [1] I didn't check with current sources, but back then the following
>>>>    variable contents were problematic:
>>>>
>>>>    * define foo = @set1 (a set named 'set1' must exist)
>>>>    * define foo = { 1024 }
>>>>    * define foo = *
>>>
>>> Yes I am looking to the report and why current version fails when the jump is to a non-base chain because I tested that some months ago.
>>>
>>> I will catch up with more details in a few hours. Sorry for the inconveniences.
>>
>> Fernando, in case Pablos patch v2 fixes the reported bug, could you
>> followup with a test case?  It would help when someone tries to remove
>> "unneeded code" in the future ;-)

I have been taking a look to the shell tests and we already have some
tests that cover these cases "tests/shell/testcases/chains/0001jumps_0",
"tests/shell/testcases/nft-f/0018jump_variable_0",
"tests/shell/testcases/nft-f/0019jump_variable_1",
"tests/shell/testcases/nft-f/0020jump_variable_1".

Also I have tested Pablo's v2 patch and it works fine for me.

I would like to know how could I prevent this kind of situations in the
future. Is there a way to automatically test your patch with other
relevant kernel versions?

Thanks! :-)

> 
> I'm not sure it's worth a test for this unlikely corner case.
> 
> There are thousands of paths where we're not performing strict
> expression validation as in this case... and if you really want to get
> this right.
>
