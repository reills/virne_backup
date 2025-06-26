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
  id 122
  arrival_time 2169.953480338624
  lifetime 2064.141560419604
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 25
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 17
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 15
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 25
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 22
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 5
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
]
