Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D694113A4
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Sep 2021 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhITLkg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Sep 2021 07:40:36 -0400
Received: from mail.netfilter.org ([217.70.188.207]:37876 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhITLkg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:40:36 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4330F605E1;
        Mon, 20 Sep 2021 13:37:51 +0200 (CEST)
Date:   Mon, 20 Sep 2021 13:39:04 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_log v3] src: doc: revise doxygen for module
 "Netlink message helper functions"
Message-ID: <YUhy2NgyV0tx7qct@salvia>
References: <20210916025822.14231-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916025822.14231-1-duncan_roe@optusnet.com.au>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:58:22PM +1000, Duncan Roe wrote:
> Adjust style to work better in a man page.
> Document actual return values.
> Replace qnum with gnum (and in .h and utils/).
> Show possible copy modes (rather than refer users to header file)

Applied, thanks.
