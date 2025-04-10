graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1009
  arrival_time 21547.734905942823
  lifetime 809.695323617906
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 36
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 14
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 28
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 8
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 27
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 13
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 13
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
]
