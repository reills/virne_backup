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
  id 746
  arrival_time 15819.603915092186
  lifetime 744.4462581962849
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 13
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 49
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 29
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 2
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 26
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
]
