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
  id 457
  arrival_time 8667.564636172106
  lifetime 3167.0637131629696
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 32
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 47
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 47
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 32
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 0
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 13
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
]
