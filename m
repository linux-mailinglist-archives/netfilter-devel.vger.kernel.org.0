Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE237CCAA
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Jul 2019 21:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfGaTVn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Jul 2019 15:21:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35770 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbfGaTVm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:21:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so60807803wmg.0
        for <netfilter-devel@vger.kernel.org>; Wed, 31 Jul 2019 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zWfo0kXaKzgB+THLewr7IstQfVGVKq6YoL33MlH9Qkk=;
        b=lHsnZHeS4vtdhev0vhGYDSS1s74v9c13UxD6bbaSQ+E+OtQtAHAioSsnZjoTTH3gO/
         p2IJOUtmSR8AqPEgOYzDg9UEe1VjYnedjmJGP5+rvjiK28pSV1l3fz0lGMgYUn9F2+Ch
         59hcdYA7EjFzEzngPqoRI/CWRClEyYzNE3NWpi9uXb8VXWQaghwYWK97fhDmeZuOmm+N
         RrQTyMuFcPFUvFyO/dZR6o0lBegY0Ui0/Ug24tLdoNz65aGAcM3PQctfB+hlMa+Qrk5H
         UI9N/XFN41eCijM7PK/mf7WUbz06nM1SgLFo50afRDgQC8vMSPMNx8xFDUQJPKZE5hPS
         U1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zWfo0kXaKzgB+THLewr7IstQfVGVKq6YoL33MlH9Qkk=;
        b=Z5kwV+BCqi4C1EkwUOBvVF4i0hJjhRzoHDvvtLV/MDFfohTgse5Z8iPG5D70ZaBicV
         5nAV2tAFz5O4tQLmfTR+K3C7j5uNsIw3LRO+vQC2fCtdXM2P4pWCEW/A42UvuSmIe1bq
         7CWls4/uWU9+x6jpvdEpjsLR4nd5ktkb0PVZolNCPZyHXOSjGSHw6ZwYCOIi/yedfYRF
         on+HDMzNDn/PDgB7dXBI36unKIuaXm3q6XXPpxawMp/8F+1eK3asS+/mxducdp5JyL6F
         JLM6c1iBQlUVg/rfc+FODniNUgYBCFkXQ6lN1jVFQXyuaci3eLQf+poXYwiN7+MpX5eV
         OY/Q==
X-Gm-Message-State: APjAAAXn6VgN3uZyOgr2D16/Jnk8X9/zX115mi73oDC9wIZxbAoTiT5N
        nYMFIp9BbOJhZaOHNFSaS4Y=
X-Google-Smtp-Source: APXvYqwFzredyJjyHF/FGVWTjHn7ZRN0IH/XoJtO3U4olM+yGzMWsPyozmfRssTw2y2xc695DL9t5Q==
X-Received: by 2002:a05:600c:254b:: with SMTP id e11mr104490516wma.171.1564600900513;
        Wed, 31 Jul 2019 12:21:40 -0700 (PDT)
Received: from localhost ([80.82.155.62])
        by smtp.gmail.com with ESMTPSA id g19sm130426646wrb.52.2019.07.31.12.21.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 12:21:39 -0700 (PDT)
Date:   Wed, 31 Jul 2019 21:21:35 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     wenxu@ucloud.cn
Cc:     pablo@netfilter.org, fw@strlen.de, jakub.kicinski@netronome.com,
        netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] flow_offload: add indr-block in
 nf_table_offload
Message-ID: <20190731192135.GA2324@nanopsycho>
References: <1564560753-32603-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564560753-32603-1-git-send-email-wenxu@ucloud.cn>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Wed, Jul 31, 2019 at 10:12:27AM CEST, wenxu@ucloud.cn wrote:
>From: wenxu <wenxu@ucloud.cn>
>
>This series patch make nftables offload support the vlan and
>tunnel device offload through indr-block architecture.
>
>The first four patches mv tc indr block to flow offload and
>rename to flow-indr-block.
>Because the new flow-indr-block can't get the tcf_block
>directly. The fifthe patch provide a callback list to get 
>flow_block of each subsystem immediately when the device
>register and contain a block.
>The last patch make nf_tables_offload support flow-indr-block.
>
>wenxu (6):
>  cls_api: modify the tc_indr_block_ing_cmd parameters.
>  cls_api: replace block with flow_block in tc_indr_block_dev
>  cls_api: add flow_indr_block_call function
>  flow_offload: move tc indirect block to flow offload
>  flow_offload: support get flow_block immediately
>  netfilter: nf_tables_offload: support indr block call

Wenxu, this is V5. Please repost is as V5. Also please provide per-patch
changelog, as you did with the previous versions. Thanks!
