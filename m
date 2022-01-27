Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C145049EA43
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jan 2022 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbiA0SVE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Jan 2022 13:21:04 -0500
Received: from mail.netfilter.org ([217.70.188.207]:40482 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiA0SVE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:21:04 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id F0A9960693;
        Thu, 27 Jan 2022 19:17:58 +0100 (CET)
Date:   Thu, 27 Jan 2022 19:20:58 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eugene Crosser <crosser@average.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2 2/2] Handle retriable errors from mnl functions
Message-ID: <YfLiitlOadGmfK7v@salvia>
References: <20211209182607.18550-1-crosser@average.org>
 <20211209182607.18550-3-crosser@average.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209182607.18550-3-crosser@average.org>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 09, 2021 at 07:26:07PM +0100, Eugene Crosser wrote:
> rc == -1 and errno == EINTR mean:
> 
> mnl_socket_recvfrom() - blindly rerun the function
> mnl_cb_run()          - restart dump request from scratch
> 
> This commit introduces handling of both these conditions

Sorry it took me a while to come back to this.

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220127181835.571673-1-pablo@netfilter.org/

This follows the same approach as src/mnl.c, no need to close the
reopen the socket to drop the existing messages.
