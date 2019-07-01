Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6BA13179
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 May 2019 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfECPv4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 May 2019 11:51:56 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48504 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfECPv4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 May 2019 11:51:56 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hMaTa-000190-Js; Fri, 03 May 2019 17:51:54 +0200
Date:   Fri, 3 May 2019 17:51:54 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Eric Garver <eric@garver.life>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] py: fix missing decode/encode of strings
Message-ID: <20190503155154.GM31599@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Eric Garver <eric@garver.life>,
        netfilter-devel@vger.kernel.org
References: <20190501163500.29662-1-eric@garver.life>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501163500.29662-1-eric@garver.life>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, May 01, 2019 at 12:35:00PM -0400, Eric Garver wrote:
> When calling ffi functions we need to convert from python strings to
> utf-8. Then convert back for any output we receive.

So the problem is passing utf-8 encoded strings as command?

[...]
> -        rc = self.nft_run_cmd_from_buffer(self.__ctx, cmdline)
> -        output = self.nft_ctx_get_output_buffer(self.__ctx)
> -        error = self.nft_ctx_get_error_buffer(self.__ctx)
> +        rc = self.nft_run_cmd_from_buffer(self.__ctx, cmdline.encode("utf-8"))
> +        output = self.nft_ctx_get_output_buffer(self.__ctx).decode("utf-8")
> +        error = self.nft_ctx_get_error_buffer(self.__ctx).decode("utf-8")

Should the encoding be made configurable? I see encode() and decode()
parameters are optional, but as soon as I call them with a string
containing umlauts I get errors. So not sure if that would be an
alternative.

BTW, thanks for all these fixes!

Cheers, Phil
