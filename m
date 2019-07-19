Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B46E22D
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jul 2019 10:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfGSIBI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jul 2019 04:01:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44740 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfGSIBI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:01:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so31242772wrf.11
        for <netfilter-devel@vger.kernel.org>; Fri, 19 Jul 2019 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w1ekx0Whjc70X9EHRUdvyi9C9KHDsQu98PqfbPr/bGs=;
        b=Qhjw7ZJSPvdObZzE4cD0oK2pXS3jEIQwC/omTVErYrZD99fqTaIua/H9QAR1vQUntp
         uBK0/M/4clutNBHN6+76MDaOrhz/rllLhZ4BCgWUEB2XExxfUwC009lXtTjjwhmQLoOV
         HhWcXLJ254XnPloic9LGfOEHWvtwX+R8smQ+96SvGB8hOwidu32QfeiVT2KyYpadJVGZ
         WLtulBhuF1AtUmL8vLqFz/lhvSo+2eDmnv49sMvTw+Iq5NvPgLHAYy8Z2nq6L1+jTGk/
         Xe9Zl+I2ByK7qKCKqk1DNZiLi7yRxma+55TP323hd82UiBc89ryD2x5WU3+INPdgLyKg
         ZVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w1ekx0Whjc70X9EHRUdvyi9C9KHDsQu98PqfbPr/bGs=;
        b=BcsRZXKf5qHjrEmrBa6/lsvMmIF7W6K458ZvXPge3QBvLZpRt78jeEzEYnnpmgqp2A
         pq5Yy7aKnUWSDedgIT0dJn5a5ROmq6PAqhpSICdBuMWfEhQTL/QZ4C7+i1VigImeywjY
         /doFUqhTn1hyYTzs2L/PbcLN/D2RBBBvT6yIMqJ/yp8gjSqhGSx12jZ2TlgwOI9YvGh5
         WD0OeFpsonXK4yLUFMJMzGxN16KKEASAjly7giz7NsIpFotzIfsqk1pnsXIdzApQjswv
         uHJzscoXwlrF6Yf3SfxXtEMwV29k7dvqiasXv7dG1fRJfb8qnjhxloIQ+EW64Ea6/dcL
         OxsQ==
X-Gm-Message-State: APjAAAWUvwg7hG2P7zDuymfrbJ2t4LCNtJlDh0X3K4jqGyoM6nX7uIKH
        NsQcmxTxTJn2mvyq8zOOwEU=
X-Google-Smtp-Source: APXvYqzIZ+37rAy8w3si0PC2zjPhhQUX7DvNsEY4Bw4zHwOqQzM2Qx84n3WVlbPn254RIws++WCHkw==
X-Received: by 2002:a5d:5348:: with SMTP id t8mr52942933wrv.159.1563523266469;
        Fri, 19 Jul 2019 01:01:06 -0700 (PDT)
Received: from localhost (ip-62-24-94-150.net.upcbroadband.cz. [62.24.94.150])
        by smtp.gmail.com with ESMTPSA id g12sm38848990wrv.9.2019.07.19.01.01.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 01:01:06 -0700 (PDT)
Date:   Fri, 19 Jul 2019 10:01:05 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, jakub.kicinski@netronome.com,
        pshelar@ovn.org
Subject: Re: [PATCH net,v4 4/4] net: flow_offload: add flow_block structure
 and use it
Message-ID: <20190719080105.GC2230@nanopsycho>
References: <20190718175931.13529-1-pablo@netfilter.org>
 <20190718175931.13529-5-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718175931.13529-5-pablo@netfilter.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thu, Jul 18, 2019 at 07:59:31PM CEST, pablo@netfilter.org wrote:
>This object stores the flow block callbacks that are attached to this
>block. Update flow_block_cb_lookup() to take this new object.
>
>This patch restores the block sharing feature.
>
>Fixes: da3eeb904ff4 ("net: flow_offload: add list handling functions")
>Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Acked-by: Jiri Pirko <jiri@mellanox.com>
