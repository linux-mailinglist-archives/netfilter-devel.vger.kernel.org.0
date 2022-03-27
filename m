Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9C4E86F2
	for <lists+netfilter-devel@lfdr.de>; Sun, 27 Mar 2022 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiC0Idk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 27 Mar 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiC0Idk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:33:40 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0902D337
        for <netfilter-devel@vger.kernel.org>; Sun, 27 Mar 2022 01:32:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nYOJZ-0008Gc-Pr; Sun, 27 Mar 2022 10:31:57 +0200
Date:   Sun, 27 Mar 2022 10:31:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     pablo@netfilter.org, fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] examples: fix compiler warning
Message-ID: <20220327083157.GA19212@breakpoint.cc>
References: <20220327055925.9063-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327055925.9063-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Duncan Roe <duncan_roe@optusnet.com.au> wrote:
> (introduced by c3bada27)

applied, thanks.
