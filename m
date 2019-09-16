Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830D1B3C43
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Sep 2019 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfIPOLT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Sep 2019 10:11:19 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34298 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbfIPOLT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:11:19 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i9rio-0001f9-4L; Mon, 16 Sep 2019 16:11:18 +0200
Date:   Mon, 16 Sep 2019 16:11:18 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Eric Jallot <ejallot@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src: parser_json: fix crash while restoring secmark
 object
Message-ID: <20190916141118.GN10656@breakpoint.cc>
References: <20190916092943.35543-1-ejallot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916092943.35543-1-ejallot@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Eric Jallot <ejallot@gmail.com> wrote:
> Before patch:
>  # nft -j list secmarks | tee rules.json | jq '.'
>  {

Applied, thanks.
