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
  id 1487
  arrival_time 32268.4797215915
  lifetime 2976.221411365818
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 1
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 36
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 39
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 12
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 45
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 33
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
]
