Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8558F76F
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Aug 2022 08:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiHKGF3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Aug 2022 02:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiHKGF3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:05:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463546D9E4
        for <netfilter-devel@vger.kernel.org>; Wed, 10 Aug 2022 23:05:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oM1Jt-0004j3-GM; Thu, 11 Aug 2022 08:05:25 +0200
Date:   Thu, 11 Aug 2022 08:05:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [RFC] concat with dynamically sized fields like vlan id
Message-ID: <YvScJVnouDEcFXoM@strlen.de>
References: <20200501205915.24682-1-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501205915.24682-1-michael-dev@fami-braun.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Michael Braun <michael-dev@fami-braun.de> wrote:
> This enables commands like
> 
>  nft set bridge t s4 '{typeof vlan id . ip daddr; elements = { 3567 .
> 1.2.3.4 }; }'
> 
> Which would previously fail with
>   Error: can not use variable sized data types (integer) in concat
>   expressions

I've cleaned up the testcase added in this patch and applied it to git.
