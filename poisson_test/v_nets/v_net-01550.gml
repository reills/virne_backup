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
  id 1550
  arrival_time 34189.482104833376
  lifetime 50.43133669528163
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 20
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 0
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 3
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 25
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
]
