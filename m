Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB62B945
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 May 2019 18:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfE0Q4y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 May 2019 12:56:54 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:45772 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfE0Q4y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 May 2019 12:56:54 -0400
Received: from sys.soleta.eu ([212.170.55.40] helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <pablo@gnumonks.org>)
        id 1hVIva-00023v-65; Mon, 27 May 2019 18:56:52 +0200
Date:   Mon, 27 May 2019 18:56:49 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] parser_json: Fix and simplify verdict expression
 parsing
Message-ID: <20190527165649.2vxl7yehmwc2frfv@salvia>
References: <20190527113700.8541-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527113700.8541-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 27, 2019 at 01:37:00PM +0200, Phil Sutter wrote:
> Parsing of the "target" property was flawed in two ways:
> 
> * The value was extracted twice. Drop the first unconditional one.
> * Expression allocation required since commit f1e8a129ee428 was broken,
>   The expression was allocated only if the property was not present.

Applied, thanks.
