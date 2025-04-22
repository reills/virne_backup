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
  id 189
  arrival_time 3411.1958409586396
  lifetime 436.1937054093852
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 27
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 46
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 23
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 10
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 28
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 14
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
]
